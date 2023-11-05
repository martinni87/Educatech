//
//  LoginView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
            TextField("Password", text: $password)
            Button("Login") {
                authViewModel.signInEmail(email: email, password: password)
            }
        }
        .alert(isPresented: $authViewModel.allowContinue) {
            Alert(title: Text("Something went wrong"),
                  message: Text(self.authViewModel.requestErrorMsg ?? "Unknown error"),
                  dismissButton: .default(Text("OK")))
        }
    }
}
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
