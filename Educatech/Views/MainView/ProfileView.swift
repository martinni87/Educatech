//
//  ProfileView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 20/9/23.
//

import SwiftUI
import MessageUI

struct ProfileView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    
    @State var newAddedCategory: String = ""
    @State var isAddingNewCategory: Bool = false
    @State var categoriesToShow: [String] = []
    @State var errorAddingEmptyCategory: Bool = false
    
    @State var errorContactSupport = false
    @State var sendEmailResult: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingEmailView = false
    @State var emailBody: String = ""
    @State var emailData: EmailDataModel?
    
    @Environment (\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            SignoutButtonViewComponent(authViewModel: authViewModel)
                .padding(.top)
                .padding(.trailing)
            List {
                
                Section("Personal info") {
                    Text("UUID: ").bold() + Text("\(authViewModel.userAuth?.id ?? "No id")").foregroundStyle(.gray)
                    Text("Email:: ").bold() + Text("\(authViewModel.userData?.email ?? "No email")").foregroundStyle(.gray)
                    Text("Username: ").bold() + Text("\(authViewModel.userData?.username ?? "No username")").foregroundStyle(.gray)
                }
                
                Section("My categories") {
                    ForEach(authViewModel.userData?.categories ?? [""], id: \.self) { category in
                        Text(category)
                            .swipeActions {
                                Button("Delete") {
                                    if let userData = authViewModel.userData {
                                        //This are the modifications to be done before invoking editUserData
                                        var categories = userData.categories
                                        categories.removeAll { $0 == category }
                                        let newUserData = UserDataModel(id: userData.id,
                                                                        email: userData.email,
                                                                        username: userData.username,
                                                                        isEditor: userData.isEditor,
                                                                        categories: categories,
                                                                        contentCreated: userData.contentCreated,
                                                                        subscriptions: userData.subscriptions)
                                        //With modifications locally, invoke editUserData
                                        authViewModel.editUserData(changeTo: newUserData,
                                                                   collection: collectionsViewModel)
                                    }
                                }
                                .tint(.pink)
                            }
                    }
                    if isAddingNewCategory {
                        Picker("Categories", selection: $newAddedCategory) {
                            ForEach(self.categoriesToShow, id:\.self) { category in
                                Text(category)
                            }
                        }
                        .task {
                            if let myCategories = authViewModel.userData?.categories {
                                let newArray = Categories.allCases.filter { !myCategories.contains($0.rawValue) }
                                self.categoriesToShow = newArray.map { $0.rawValue }
                                self.newAddedCategory = newArray.map { $0.rawValue }[0]
                            }
                            else {
                                self.categoriesToShow = Categories.allCases.map { $0.rawValue }
                                self.newAddedCategory = Categories.allCases.map { $0.rawValue }[0]
                            }
                        }
                        Button("Cancel") {
                            self.isAddingNewCategory.toggle()
                        }
                    }
                    Button(isAddingNewCategory ? " Save" : "+ Add new") {
                        if isAddingNewCategory {
                            if self.newAddedCategory == "" {
                                self.errorAddingEmptyCategory.toggle()
                            }
                            else {
                                if let userData = authViewModel.userData {
                                    //This are the modifications to be done before invoking editUserData
                                    var categories = userData.categories
                                    categories.append(newAddedCategory)
                                    let newUserData = UserDataModel(id: userData.id,
                                                                    email: userData.email,
                                                                    username: userData.username,
                                                                    isEditor: userData.isEditor,
                                                                    categories: categories,
                                                                    contentCreated: userData.contentCreated,
                                                                    subscriptions: userData.subscriptions)
                                    //With modifications locally, invoke editUserData
                                    authViewModel.editUserData(changeTo: newUserData,
                                                               collection: collectionsViewModel)
                                }
                            }
                        }
                        isAddingNewCategory.toggle()
                    }
                }
                
                Section("My subscriptions") {
                    ForEach(authViewModel.userData?.subscriptions ?? [""], id: \.self) { subscription in
                        //Giving nice format to text
                        let subs = subscription.components(separatedBy: CharacterSet.decimalDigits).joined()
                            .uppercased()
                            .replacingOccurrences(of: "_", with: " ")
                        //Printing text in screen
                        Text(subs)
                            .swipeActions {
                                Button("Delete") {
                                    if let userData = authViewModel.userData {
                                        //This are the modifications to be done before invoking editUserData
                                        var subscriptions = userData.subscriptions
                                        subscriptions.removeAll { $0 == subscription }
                                        let newUserData = UserDataModel(id: userData.id,
                                                                        email: userData.email,
                                                                        username: userData.username,
                                                                        isEditor: userData.isEditor,
                                                                        categories: userData.categories,
                                                                        contentCreated: userData.contentCreated,
                                                                        subscriptions: subscriptions)
                                        //With modifications locally, invoke editUserData
                                        authViewModel.editUserData(changeTo: newUserData,
                                                                   collection: collectionsViewModel)
                                    }
                                }
                                .tint(.pink)
                            }
                    }
                }
                if authViewModel.userData?.isEditor ?? false {
                    Section("My content created") {
                        ForEach(authViewModel.userData?.contentCreated ?? [""], id: \.self) { courseID in
                            //Giving nice format to text
                            let courseTitle = courseID.components(separatedBy: CharacterSet.decimalDigits).joined()
                                .uppercased()
                                .replacingOccurrences(of: "_", with: " ")
                            //Printing text in screen
                            Text(courseTitle)
                        }
                    }
                    .task {
                        authViewModel.getCurrentUserData()
                        collectionsViewModel.getCoursesByCreatorID(creatorID: authViewModel.userAuth?.id ?? "0")
                    }
                }
            }
            Button {
                if MFMailComposeViewController.canSendMail() {
                    if let id = self.authViewModel.userData?.id, let email = authViewModel.userData?.email {
                        self.emailData = EmailDataModel(id: id, email: email)
                        self.isShowingEmailView.toggle()
                    }
                    else {
                        self.errorContactSupport.toggle()
                    }
                }
                else {
                    self.errorContactSupport.toggle()
                }
            } label: {
                Label("Contact Support", systemImage: "wrench.adjustable.fill")
                    .bold()
                    .frame(maxWidth: .infinity)
            }
            .background(Color.clear)
            .foregroundColor(Color.accentColor)
            .cornerRadius(10)
            .padding(20)
        }
        .sheet(isPresented: $isShowingEmailView){
            MailViewComponent(result: self.$sendEmailResult, emailData: self.$emailData)
        }
        // Alert in case contact support throws error
        .alert("Contact Support", isPresented: $errorContactSupport) {
            Button("OK"){
                self.errorContactSupport.toggle()
            }
        } message: {
            Text("Can't open any email client. Do you have a mailing app installed?")
        }
        // Alert in case adding category fails
        .alert("Can't add empty categories", isPresented: $errorAddingEmptyCategory) {
            Button("OK"){
                self.errorAddingEmptyCategory.toggle()
            }
        } message: {
            Text("Can't add an empty category. You must choose one new category or cancel.")
        }
    }
}

#Preview {
    ProfileView(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel())
}

//    @ObservedObject var authViewModel: AuthViewModel
//    @State var showLinkEmailForm = false
//    @State var email = ""
//    @State var password = ""
//    @State var errorContactSupport = false
//    @State var sendEmailResult: Result<MFMailComposeResult, Error>? = nil
//    @State var isShowingEmailView = false
//    @State var emailBody: String = ""
//    @State var emailData: EmailDataModel?
//
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                VStack {
//                    Form {
//                        Section("My info") {
//                            List {
//                                Text("UUID: \(authViewModel.user?.id ?? "00000")")
//                                Text("Email: \(authViewModel.user?.email ?? "No mail")")
//                            }
//                        }
//                        Section("Link Providers") {
//                            Button {
//                                showLinkEmailForm.toggle()
//                            } label: {
//                                HStack {
//                                    Image("logo_email")
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(height: 25)
//                                        .padding(.trailing, 10)
//                                    Text("Link email")
//                                }
//                            }
//                            .disabled(authViewModel.isEmailAndPasswordLinked())
//
//                            Button {
//                                authViewModel.linkFacebook()
//                            } label: {
//                                HStack {
//                                    Image("logo_facebook")
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(height: 25)
//                                        .padding(.trailing, 10)
//                                    Text("Link Facebook")
//                                }
//                            }
//                            .disabled(authViewModel.isFacebookLinked())
//
//                            Button {
//                                authViewModel.linkGoogle()
//                            } label: {
//                                HStack {
//                                    Image("logo_google")
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(height: 25)
//                                        .padding(.trailing, 10)
//                                    Text("Link Google")
//                                }
//                            }
//                            .disabled(authViewModel.isGoogleLinked())
//
//                        }
//                    }
//                    VStack {
//                        Button(action: {
//                            if MFMailComposeViewController.canSendMail() {
//                                if let id = authViewModel.user?.id, let email = authViewModel.user?.email {
//                                    self.emailData = EmailDataModel(id: id, email: email)
//                                    self.isShowingEmailView.toggle()
//                                }
//                                else {
//                                    self.errorContactSupport.toggle()
//                                }
//                            }
//                            else {
//                                self.errorContactSupport.toggle()
//                            }
//                        }, label: {
//                            Label("Contact Support", systemImage: "wrench.adjustable.fill")
//                                .bold()
//                                .frame(maxWidth: .infinity)
//                        })
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                        SignoutButton(authViewModel: authViewModel)
//                    }
//                    .padding(.horizontal, 20)
//                    .padding(.bottom, 50)
//                }
//                .sheet(isPresented: $isShowingEmailView){
//                    MailView(result: self.$sendEmailResult, emailData: self.$emailData)
//                }
//                if showLinkEmailForm {
//                    Rectangle()
//                        .fill(Color.white)
//                        .cornerRadius(10)
//                        .frame(width: 300, height: 300)
//                        .shadow(radius: 10)
//                        .overlay {
//                            VStack {
//                                VStack {
//                                    CustomTextField(fieldType: .singleLine,
//                                              label: "Email", placeholder: "jondoe@mail.com",
//                                              variable: $email,
//                                              autocapitalization: false)
//                                    CustomTextField(fieldType: .secure,
//                                              label: "Password", placeholder: "********",
//                                              variable: $password,
//                                              autocapitalization: false)
//                                }
//                                .padding()
//                                HStack {
//                                    Spacer()
//                                    Button("Link") {
//                                        authViewModel.linkEmailAndPassword(email: email, password: password)
//                                        showLinkEmailForm.toggle()
//                                    }
//                                    .tint(.green)
//                                    Spacer()
//                                    Button("Cancel"){
//                                        showLinkEmailForm.toggle()
//                                    }
//                                    .tint(.pink)
//                                    Spacer()
//                                }
//                                .padding()
//                            }
//                            .background(Color.white)
//                        }
//                }
//            }
//            // Alert in case contact support throws error
//            .alert("Contact Support", isPresented: $errorContactSupport) {
//                Button("OK"){
//                    errorContactSupport.toggle()
//                }
//            } message: {
//                Text("Can't open any email client. Do you have a mailing app installed?")
//            }
//            // Alert after link email workflow happens
//            .alert("Link provider", isPresented: $authViewModel.showAlert) {
//                Button("Aceptar") {
//                    print("Dismiss")
//                }
//            } message: {
//                if authViewModel.didLinkedAccount {
//                    Text("Your account has been linked")
//                }
//                else {
//                    Text("Something went wrong. Try again later or contact the sysadmin")
//                }
//            }
//        }
//        .task {
//            authViewModel.getCurrentProvider()
//        }
//    }
//}
