//
//  RegistrationFormViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 1/11/23.
//

import SwiftUI

struct RegistrationFormViewComponent: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @Binding var formInputs: RegistrationFormInputs
 
    var body: some View {
        Group {
            VStack {
                RegTextFieldViewComponent(authViewModel: authViewModel, type: .simple, variable: $formInputs.email, secureIsActive: false, errorMsg: authViewModel.emailErrorMsg, label: "Email", placeholder: "you@mail.com", tooltip: "Write a complete email address, example: you@mail.com")
                RegTextFieldViewComponent(authViewModel: authViewModel, type: .simple, variable: $formInputs.username, secureIsActive: false, errorMsg: authViewModel.usernameErrorMsg, label: "Username", placeholder: "Username", tooltip: "Write a username you want. It is unique as it is the visible identification between users")
            }
            VStack {
                RegTextFieldViewComponent(authViewModel: authViewModel, type: .secure, variable: $formInputs.password, secureIsActive: true, errorMsg: authViewModel.passwordErrorMsg, label: "Password", placeholder: "Password", tooltip: "Use at least an 8 character password with numbers, symbols a capitals")
                RegTextFieldViewComponent(authViewModel: authViewModel, type: .secure, variable: $formInputs.repeatPassword, secureIsActive: true, errorMsg: authViewModel.repeatPasswordErrorMsg, label: "Repeat password", placeholder: "Repeat password", tooltip: "Repeat the same password you put in the field above")
            }
        }
    }
    
}

#Preview {
    RegistrationFormViewComponent(authViewModel: AuthViewModel(), formInputs: .constant(RegistrationFormInputs()))
}
