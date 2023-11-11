//
//  RegisterSubView2.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 4/11/23.
//

import SwiftUI

enum CustomFieldType {
    case simple, secure
}

struct RegisterSubView2: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @Binding var formInputs: RegistrationFormInputs
    @Environment (\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        //MARK: Registration form
        NavigationStack {
            HeaderViewComponent(headerModel: HeaderModel(headerType: .register2), frameSize: 70)
            Spacer()
            if verticalSizeClass == .compact {
                HStack {
                    RegistrationFormViewComponent(authViewModel: authViewModel, formInputs: $formInputs)
                        .disabled(authViewModel.allowContinue)
                }
            }
            else {
                VStack {
                    RegistrationFormViewComponent(authViewModel: authViewModel, formInputs: $formInputs)
                        .disabled(authViewModel.allowContinue)
                }
            }
            Spacer()
            Text("Everything looks find! Click 'Next' to continue.")
                .foregroundStyle(authViewModel.allowContinue ? Color.accentColor : Color.clear)
            Spacer()
            
            HStack {
                if authViewModel.allowContinue {
                    NavigationLink {
                        RegisterSubView3(authViewModel: authViewModel, formInputs: $formInputs)
                    } label: {
                        ButtonViewComponent(title: "Next", foregroundColor: .gray.opacity(0.25), titleColor: .accentColor)
                    }
                }
                else {
                    Button {
                        authViewModel.registrationFormValidations(formInputs)
                    } label: {
                        ButtonViewComponent(title: "Check fields", foregroundColor: .gray.opacity(0.25), titleColor: .accentColor)
                    }
                }
                Button {
                    authViewModel.cleanCache()
                    formInputs = RegistrationFormInputs()
                } label: {
                    ButtonViewComponent(title: "Clean form", foregroundColor: .gray.opacity(0.25), titleColor: (formInputs.email == "" && formInputs.username == "" && formInputs.password == "" && formInputs.repeatPassword == "") ? .gray : .pink.opacity(0.5))
                }
                .disabled(formInputs.email == "" && formInputs.username == "" && formInputs.password == "" && formInputs.repeatPassword == "")
            }
        }
        .padding()
    }
}
            
            
            
            
            
            
            
//            if allowedToContinue  && authViewModel.requestErrorMsg == nil {
//                NavigationLink {
//                    RegisterSubView3(authViewModel: authViewModel, formInputs: $formInputs)
//                        .navigationBarBackButtonHidden(true)
//                } label: {
//                    ButtonViewComponent(title: "Next", foregroundColor: .gray.opacity(0.3), titleColor: .accentColor)
//                }
//            }
//            else {
//                ButtonViewComponent(title: "Next", foregroundColor: .gray.opacity(0.3), titleColor: .red)
//                    .onTapGesture {
//                        authViewModel.cleanCache()
//                        let _ = authViewModel.registerFormValidations(formInputs)
//                        if authViewModel.requestErrorMsg == nil &&
//                            authViewModel.emailErrorMsg == nil &&
//                            authViewModel.usernameErrorMsg == nil &&
//                            authViewModel.passwordErrorMsg == nil &&
//                            authViewModel.repeatPasswordErrorMsg == nil {
//                            allowedToContinue.toggle()
//                        }
//                    }
//            }
//        }
//        .padding()
//    }
//}

#Preview {
    RegisterSubView2(authViewModel: AuthViewModel(), formInputs: .constant(RegistrationFormInputs()))
}
