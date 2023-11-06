//
//  LoginView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import SwiftUI

struct LoginView: View {

    @ObservedObject var authViewModel: AuthViewModel
    @State var formInputs = LoginFormInputs()
    @Environment (\.verticalSizeClass) var verticalSizeClass

    var body: some View {
        ScrollView {
            HeaderViewComponent(headerModel: HeaderModel(headerType: .login), frameSize: 70)
                .padding()
            VStack {
                TextFieldViewComponent(authViewModel: authViewModel, type: .simple, variable: $formInputs.email, secureIsActive: false, errorMsg: authViewModel.emailErrorMsg, label: "Email", placeholder: "your@mail.com", tooltip: "Use the email you've register previously")
                TextFieldViewComponent(authViewModel: authViewModel, type: .secure, variable: $formInputs.password, secureIsActive: true, errorMsg: authViewModel.passwordErrorMsg, label: "Password", placeholder: "Your password here", tooltip: "Use the password associated with your current email")
            }
            Button {
                authViewModel.signInEmail(formInputs: formInputs)
            } label: {
                ButtonViewComponent(title: "Login", foregroundColor: .accentColor, titleColor: .white)
            }
            .padding(.vertical, 20)
        }
        .padding()
        .scrollDismissesKeyboard(.never)
        .scrollIndicators(.never)
        .onAppear {
            authViewModel.cleanCache()
        }
        .alert(isPresented: $authViewModel.hasRequestError) {
            Alert(title: Text("Sign in error"),
                  message: Text("Something went wrong while attempting to access with the given credentials. Please, verify the user and password or try again later. If the error persists, please contact with the admin."),
                  dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    LoginView(authViewModel: AuthViewModel())
}













//import SwiftUI
//
//struct LoginView: View {
//    
//    @ObservedObject var authViewModel: AuthViewModel
//    @State var email = ""
//    @State var password = ""
//    
//    var body: some View {
//        VStack {
//            HeaderViewComponent(headerModel: HeaderModel(headerType: .login), frameSize: 80)
//            Spacer()
//            VStack (spacing: 20) {
//                TextFieldViewComponent(authViewModel: authViewModel,
//                                       type: .simple,
//                                       variable: $email,
//                                       secureIsActive: false,
//                                       errorMsg: authViewModel.emailErrorMsg,
//                                       label: "Email",
//                                       placeholder: "your@mail.com",
//                                       tooltip: "Use the email you registered previously")
//                TextFieldViewComponent(authViewModel: authViewModel,
//                                       type: .secure,
//                                       variable: $password,
//                                       secureIsActive: true,
//                                       errorMsg: authViewModel.passwordErrorMsg,
//                                       label: "Password",
//                                       placeholder: "Enter your password here",
//                                       tooltip: "Your current password for this account")
////                TextField("Email", text: $email)
////                SecureField("Password", text: $password)
//            }
//            .padding()
//            Spacer()
//            Button("Login") {
//                authViewModel.signInEmail(email: email, password: password)
//            }
//            Spacer()
//        }
//        .alert(isPresented: $authViewModel.allowContinue) {
//            Alert(title: Text("Something went wrong"),
//                  message: Text("Check the given credentials and if you think everything's ok but the problem persists, please contact the Admin."),
////                  message: Text(self.authViewModel.requestErrorMsg ?? "Unknown error"),
//                  dismissButton: .default(Text("OK")))
//        }
//    }
//}
















//
//    @Environment (\.verticalSizeClass) var verticalSizeClass
//    
//    @ObservedObject var authViewModel: AuthViewModel
////    @ObservedObject var userViewModel: UserViewModel
//    @State var email: String = ""
//    @State var password: String = ""
//    @State var thereIsError = false
//    
//    var body: some View {
//        VStack {
//            if verticalSizeClass == .compact {
//                HStack (spacing: 20){
//                    LoginHeaderPart()
//                    Spacer()
//                    LoginFormPart(authViewModel: authViewModel,
//                                  email: $email,
//                                  password: $password,
//                                  thereIsError: $thereIsError)
//                }
//            }
//            else {
//                VStack (spacing: 20){
//                    LoginHeaderPart()
//                    Spacer()
//                    LoginFormPart(authViewModel: authViewModel,
//                                  email: $email,
//                                  password: $password,
//                                  thereIsError: $thereIsError)
//                }
//            }
//
//            Spacer()
//        }
//        .alert(isPresented: $authViewModel.showAlert) {
//            Alert(title: Text("Something went wrong"),
//                  message: Text(self.authViewModel.error ?? "Unknown error"),
//                  dismissButton: .default(Text("OK")))
//        }
//        .padding()
//    }
//}
//
//struct LoginHeaderPart: View {
//    
//    var body: some View {
//        VStack {
//            Text("Login")
//                .font(.title)
//                .bold()
//            Spacer()
//            Image("login_pic")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 100)
//            Spacer()
//            Text("Access using the email and password you registered previously.")
//                .multilineTextAlignment(.center)
//                .foregroundStyle(Color.gray)
//                .bold()
//                .padding(.horizontal, 20)
//        }
//    }
//}
//
//struct LoginFormPart: View {
//    
//    @ObservedObject var authViewModel: AuthViewModel
//    @Binding var email: String
//    @Binding var password: String
//    @Binding var thereIsError: Bool
//    
//    var body: some View {
//            VStack {
//                CustomTextField(fieldType: .singleLine,
//                          label: "Email",
//                          placeholder: "jondoe@mail.com",
//                          variable: $email,
//                          autocapitalization: false)
//                CustomTextField(fieldType: .secure,
//                          label: "Password",
//                          placeholder: "*******",
//                          variable: $password,
//                          autocapitalization: false)
//                Button("Login"){
//                    authViewModel.signInEmail(email: email,
//                                              password: password)
//                    if let _ = authViewModel.error {
//                        thereIsError = true
//                    }
//                }
//                .buttonStyle(.bordered)
//                .tint(.green)
//            }
//            .textInputAutocapitalization(.never)
//            .textFieldStyle(.roundedBorder)
//
//    }
//}
////
////struct LoginView_Previews: PreviewProvider {
////    static var previews: some View {
////        LoginView(authViewModel: AuthViewModel(), userViewModel: UserViewModel())
////    }
////}
