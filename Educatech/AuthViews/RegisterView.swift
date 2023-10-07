//
//  RegisterView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import SwiftUI

struct RegisterView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @State var email: String = ""
    @State var password: String = ""
    @State var thereIsError = false
    
    var body: some View {
        VStack {
            Text("Register")
                .font(.title)
                .bold()
            Spacer()
            VStack (spacing: 20){
                Group {
                    TextField("Email", text: $email)
                    SecureField("Password", text: $password)
                }
                .textInputAutocapitalization(.never)
                .textFieldStyle(.roundedBorder)
                Button("Register"){
                    authViewModel.signUpEmail(email: email,
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
        .alert(isPresented: $thereIsError) {
            Alert(title: Text("Something went wrong"),
                  message: Text(self.authViewModel.error ?? "Unknown error"),
                  dismissButton: .default(Text("OK")))
        }
        .padding()
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(authViewModel: AuthViewModel())
    }
}
