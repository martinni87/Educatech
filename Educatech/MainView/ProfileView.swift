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
    @State var showLinkEmailForm = false
    @State var email = ""
    @State var password = ""
    @State var errorContactSupport = false
    @State var sendEmailResult: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingEmailView = false
    @State var emailBody: String = ""
    @State var emailData: EmailData?
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Form {
                        Section("My info") {
                            List {
                                Text("UUID: \(authViewModel.user?.id ?? "00000")")
                                Text("Email: \(authViewModel.user?.email ?? "No mail")")
                            }
                        }
                        Section("Link Providers") {
                            Button {
                                showLinkEmailForm.toggle()
                            } label: {
                                HStack {
                                    Image("logo_email")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 25)
                                        .padding(.trailing, 10)
                                    Text("Link email")
                                }
                            }
                            .disabled(authViewModel.isEmailAndPasswordLinked())
                            
                            Button {
                                authViewModel.linkFacebook()
                            } label: {
                                HStack {
                                    Image("logo_facebook")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 25)
                                        .padding(.trailing, 10)
                                    Text("Link Facebook")
                                }
                            }
                            .disabled(authViewModel.isFacebookLinked())
                            
                            Button {
                                authViewModel.linkGoogle()
                            } label: {
                                HStack {
                                    Image("logo_google")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 25)
                                        .padding(.trailing, 10)
                                    Text("Link Google")
                                }
                            }
                            .disabled(authViewModel.isGoogleLinked())
                            
                        }
                    }
                    VStack {
                        Button(action: {
                            if MFMailComposeViewController.canSendMail() {
                                self.emailBody =
                                """
                                <h1> Contact Support Educatech iOS </h1>
                                <ul>
                                    <li><strong>UUID: </strong>\(authViewModel.user?.id ?? "00000")</li>
                                    <li><strong>Email: </strong>\(authViewModel.user?.email ?? "No mail")</li>
                                </ul>
                                <h3>Please, describe the issue you're encountering, a request or any comment you might want to share with us:</h3>
                                <p></p>
                                """
                                self.emailData = EmailData(body: self.emailBody)
                                self.isShowingEmailView.toggle()
                            }
                            else {
                                self.errorContactSupport.toggle()
                            }
                        }, label: {
                            Label("Contact Support", systemImage: "wrench.adjustable.fill")
                                .bold()
                                .frame(maxWidth: .infinity)
                        })
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        SignoutButton(authViewModel: authViewModel)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 50)
                }
                .sheet(isPresented: $isShowingEmailView){
                    MailView(result: self.$sendEmailResult, emailData: self.$emailData)
                }
                if showLinkEmailForm {
                    Rectangle()
                        .fill(Color.white)
                        .cornerRadius(10)
                        .frame(width: 300, height: 300)
                        .shadow(radius: 10)
                        .overlay {
                            VStack {
                                VStack {
                                    FormField(fieldType: .singleLine,
                                              label: "Email", placeholder: "jondoe@mail.com",
                                              variable: $email,
                                              autocapitalization: false)
                                    FormField(fieldType: .secure,
                                              label: "Password", placeholder: "********",
                                              variable: $password,
                                              autocapitalization: false)
                                }
                                .padding()
                                HStack {
                                    Spacer()
                                    Button("Link") {
                                        authViewModel.linkEmailAndPassword(email: email, password: password)
                                        showLinkEmailForm.toggle()
                                    }
                                    .tint(.green)
                                    Spacer()
                                    Button("Cancel"){
                                        showLinkEmailForm.toggle()
                                    }
                                    .tint(.pink)
                                    Spacer()
                                }
                                .padding()
                            }
                            .background(Color.white)
                        }
                }
            }
            // Alert in case contact support throws error
            .alert("Contact Support", isPresented: $errorContactSupport) {
                Button("OK"){
                    errorContactSupport.toggle()
                }
            } message: {
                Text("Can't open any email client. Do you have a mailing app installed?")
            }
            // Alert after link email workflow happens
            .alert("Link provider", isPresented: $authViewModel.showAlert) {
                Button("Aceptar") {
                    print("Dismiss")
                }
            } message: {
                if authViewModel.didLinkedAccount {
                    Text("Your account has been linked")
                }
                else {
                    Text("Something went wrong. Try again later or contact the sysadmin")
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
        .task {
            authViewModel.getCurrentProvider()
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(authViewModel:  AuthViewModel())
    }
}
