//
//  RegisterView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import SwiftUI

struct RegisterView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @ObservedObject var authViewModel: AuthViewModel

    
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
                    authViewModel.signUpEmail(email: email, password: password)
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

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(authViewModel: AuthViewModel())
    }
}
