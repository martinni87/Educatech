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
    
    var body: some View {
        VStack {
            Text("Login")
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
                Button("Login"){
                    authViewModel.signInEmail(email: email, password: password)
                }
                .buttonStyle(.bordered)
                .tint(.green)
                if let errorMsg = authViewModel.error?.localizedDescription {
                    Text(errorMsg)
                        .bold()
                        .font(.callout)
                        .foregroundColor(.pink)
                        .padding()
                        .multilineTextAlignment(.center)
                }
            }
            Spacer()
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(authViewModel: AuthViewModel())
    }
}
