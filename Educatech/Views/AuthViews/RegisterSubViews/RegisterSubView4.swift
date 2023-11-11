//
//  RegisterSubView4.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 4/11/23.
//

import SwiftUI

struct RegisterSubView4: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @Binding var formInputs: RegistrationFormInputs
    @Environment (\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        //MARK: Check everything
        VStack {
            if verticalSizeClass == .compact {
                HStack {
                    RegistrationCheckTabView(authViewModel: authViewModel, formInputs: $formInputs)
                }
            }
            else {
                VStack {
                    RegistrationCheckTabView(authViewModel: authViewModel, formInputs: $formInputs)
                }
            }
        }
        .alert(isPresented: $authViewModel.hasRequestError) {
            Alert(title: Text("Sign up error"),
                  message: Text("Something went wrong trying to connect with the server. Please, try again later and contact the Admin if the error persists."),
                  dismissButton: .default(Text("OK")))
        }
        .padding()
    }
}

struct RegistrationCheckTabView: View {

    @ObservedObject var authViewModel: AuthViewModel
    @Binding var formInputs: RegistrationFormInputs
    @Environment (\.verticalSizeClass) var verticalSizeClass

    var body: some View {
        Group {
            HeaderViewComponent(headerModel: HeaderModel(headerType: .register4), frameSize: 70)
            VStack {
                VStack (alignment: .leading) {
                    List {
                        Text("Email: ") + Text("\(formInputs.email)").foregroundStyle(.gray)
                        Text("Username: ") + Text("\(formInputs.username)").foregroundStyle(.gray)
                        VStack (alignment: .leading) {
                            Text("Categories:")
                            ForEach(Array(formInputs.categories), id:\.self) { category in
                                Text(category).foregroundStyle(.gray)
                            }
                        }
                    }
                    .bold()
                }
                Button {
                    authViewModel.signUpEmail(formInputs: formInputs)
                } label: {
                    ButtonViewComponent(title: "Register")
                }
                .padding(.top,20)
                .padding(.bottom, 50)
            }
            .padding(.horizontal, verticalSizeClass == .compact ? 20 : 0)
        }
    }
}

#Preview {
    RegisterSubView4(authViewModel: AuthViewModel(), formInputs: .constant(RegistrationFormInputs()))
}
