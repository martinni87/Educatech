//
//  LoginView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import SwiftUI

/// The login view of the Educatech app, allowing users to sign in with their email and password.
///
/// This view includes form fields for entering email and password, along with buttons for submitting the login request and navigating to the registration view.
///
/// - Parameters:
///   - authViewModel: The view model managing authentication.
///   - formInputs: The form inputs for the login view.
///   - verticalSizeClass: The vertical size class environment variable.
struct LoginView: View {

    @ObservedObject var authViewModel: AuthViewModel
    @State var formInputs = LoginFormInputs()
    @Environment (\.verticalSizeClass) var verticalSizeClass

    var body: some View {
        ScrollView {
            HeaderViewComponent(headerModel: HeaderModel(headerType: .login), frameSize: 70)
                .padding()
            VStack {
                RegTextFieldViewComponent(authViewModel: authViewModel, type: .simple, variable: $formInputs.email, secureIsActive: false, errorMsg: authViewModel.emailErrorMsg, label: "Email", placeholder: "your@mail.com", tooltip: "Use the email you've register previously")
                RegTextFieldViewComponent(authViewModel: authViewModel, type: .secure, variable: $formInputs.password, secureIsActive: true, errorMsg: authViewModel.passwordErrorMsg, label: "Password", placeholder: "Your password here", tooltip: "Use the password associated with your current email")
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
            authViewModel.cleanAll()
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
