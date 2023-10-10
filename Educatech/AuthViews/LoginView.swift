//
//  LoginView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @State var email: String = ""
    @State var password: String = ""
    @State var thereIsError = false
    
    var body: some View {
        VStack {
            Text("Login")
                .font(.title)
                .bold()
            Spacer()
            Image("login_pic")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
            Spacer()
            Text("Access the app using the email and password you registered previously.")
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.gray)
                .bold()
                .padding(.horizontal, 20)
            Spacer()
            VStack (spacing: 20){
                Group {
                    FormField(fieldType: .singleLine,
                              label: "Email",
                              placeholder: "jondoe@mail.com",
                              variable: $email,
                              autocapitalization: false)
                    FormField(fieldType: .secure,
                              label: "Password",
                              placeholder: "*******",
                              variable: $password,
                              autocapitalization: false)
                }
                .textInputAutocapitalization(.never)
                .textFieldStyle(.roundedBorder)
                Button("Login"){
                    authViewModel.signInEmail(email: email,
                                              password: password)
                    if let _ = authViewModel.error {
                        thereIsError = true
                    }
                }
                .buttonStyle(.bordered)
                .tint(.green)
            }
            Spacer()
        }
        .alert(isPresented: $authViewModel.showAlert) {
            Alert(title: Text("Something went wrong"),
                  message: Text(self.authViewModel.error ?? "Unknown error"),
                  dismissButton: .default(Text("OK")))
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(authViewModel: AuthViewModel())
    }
}
