//
//  ProfileView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 20/9/23.
//

import SwiftUI
import MessageUI

/// A view displaying user profile information, including personal details, categories, subscriptions, and content created.
///
/// This view allows users to view and manage their profile information, including email, username, categories,
/// subscriptions, and content created. It provides options to add new categories, delete existing ones, and manage subscriptions.
///
/// - Parameters:
///   - authViewModel: An observed object representing the authentication view model.
///   - collectionsViewModel: An observed object representing the collections view model.
///   - sendEmailResult: A binding variable representing the result of sending an email.
///   - errorContactSupport: A binding variable indicating if there is an error contacting support.
///   - isShowingEmailView: A binding variable controlling the visibility of the email composition view.
///   - emailBody: A binding variable representing the body of the email to be sent.
///   - emailData: A binding variable representing the email data model.
struct ProfileView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    
    @State var newAddedCategory: String = ""
    @State var isAddingNewCategory: Bool = false
    @State var categoriesToShow: [String] = []
    @State var errorAddingEmptyCategory: Bool = false
    
    @State var unsubscribeWarning: Bool = false
    @State var deleteCategoryWarning: Bool = false
    @State var courseToUnsubscribe: CourseModel = CourseModel()
    @State var categoryToDelete: String?
    
    @Binding var sendEmailResult: Result<MFMailComposeResult, Error>?
    @Binding var errorContactSupport: Bool
    @Binding var isShowingEmailView: Bool
    @Binding var emailBody: String
    @Binding var emailData: EmailDataModel?
    
    
    @Environment (\.colorScheme) var colorScheme
    @Environment (\.verticalSizeClass) var verticalSizeClass
    @Environment (\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section("Personal info") {
                        Text("Email: ").bold() + Text("\(authViewModel.userData?.email ?? "No email")").foregroundStyle(.gray)
                        Text("Username: ").bold() + Text("\(authViewModel.userData?.username ?? "No username")").foregroundStyle(.gray)
                    }
                    
                    Section("My categories") {
                        ForEach(authViewModel.userData?.categories ?? [""], id: \.self) { category in
                            Text(category)
                                .swipeActions {
                                    Button("Delete") {
                                        categoryToDelete = category
                                        deleteCategoryWarning.toggle()
                                    }
                                    .tint(.pink)
                                }
                        }
                        if isAddingNewCategory {
                            Picker("Categories", selection: $newAddedCategory) {
                                ForEach(self.categoriesToShow, id:\.self) { category in
                                    Text(category)
                                        .bold()
                                        .swipeActions {
                                            Button("Remove") {
                                                categoryToDelete = category
                                                deleteCategoryWarning.toggle()
                                            }
                                            .tint(.pink)
                                        }
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
                                        authViewModel.editUserData(changeTo: newUserData)
                                    }
                                }
                            }
                            isAddingNewCategory.toggle()
                        }
                    }
                    
                    Section("My subscriptions") {
                        if let _ = authViewModel.userData?.subscriptions {
                            ForEach(collectionsViewModel.subscribedCourses, id:\.id) { course in
                                HStack {
                                    Text(course.title)
                                        .lineLimit(1)
                                    Spacer()
                                    Text("(\(course.category))")
                                        .foregroundStyle(Color.gray)
                                        .lineLimit(1)
                                }
                                .bold()
                                .swipeActions {
                                    Button("Unsubscribe") {
                                        courseToUnsubscribe = course
                                        unsubscribeWarning.toggle()
                                    }
                                    .tint(.pink)
                                }
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
                .frame(maxWidth: 850)
                .scrollContentBackground((horizontalSizeClass == .regular && verticalSizeClass == .regular) ? .hidden : .visible)
            }
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
        //Alert in case user wants to delete a category
        .alert("Are you sure?", isPresented: $deleteCategoryWarning) {
            Button("Yes. Proceed") {
                if let userData = authViewModel.userData {
                    var categories = userData.categories
                    categories.removeAll { $0 == self.categoryToDelete }
                    authViewModel.editUserData(
                        changeTo: UserDataModel(id: userData.id,
                                                email: userData.email,
                                                username: userData.username,
                                                isEditor: userData.isEditor,
                                                categories: categories,
                                                contentCreated: userData.contentCreated,
                                                subscriptions: userData.subscriptions))
                    self.categoryToDelete = nil
                }
            }
            Button("No. Cancel") {
                self.categoryToDelete = nil
            }
        } message: {
            Text("Are you sure you want to unsubscribe to this category?")
        }
        //Alert in case user wants to delete a subscription
        .alert("Are you sure?", isPresented: $unsubscribeWarning) {
            Button("Yes. Proceed") {
                if let userData = authViewModel.userData {
                    var subscriptions = userData.subscriptions
                    let course = self.courseToUnsubscribe
                    subscriptions.removeAll { $0 == self.courseToUnsubscribe.id }
                    authViewModel.editUserData(
                        changeTo: UserDataModel(id: userData.id,
                                                email: userData.email,
                                                username: userData.username,
                                                isEditor: userData.isEditor,
                                                categories: userData.categories,
                                                contentCreated: userData.contentCreated,
                                                subscriptions: subscriptions))
                    collectionsViewModel.editCourseData(
                        changeTo: CourseModel(id: course.id,
                                              creatorID: course.creatorID,
                                              teacher: course.teacher,
                                              title: course.title,
                                              description: course.description,
                                              imageURL: course.imageURL,
                                              category: course.category,
                                              videosURL: course.videosURL,
                                              numberOfStudents: course.numberOfStudents - 1,
                                              approved: course.approved))
                    collectionsViewModel.getSubscribedCoursesByID(coursesIDs: subscriptions)
                    self.courseToUnsubscribe = CourseModel()
                }
            }
            Button("No. Cancel") {
                self.courseToUnsubscribe = CourseModel()
            }
        } message: {
            Text("Are you sure you want to unsubscribe to the course?")
        }
    }
}

#Preview {
    ProfileView(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel(), sendEmailResult: .constant(.success(MFMailComposeResult(rawValue: 0)!)), errorContactSupport: .constant(false), isShowingEmailView: .constant(false), emailBody: .constant(""), emailData: .constant(EmailDataModel(id: "0", email: "mail")))
}
