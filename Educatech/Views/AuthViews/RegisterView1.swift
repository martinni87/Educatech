//
//  RegisterView1.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import SwiftUI

import SwiftUI

struct RegisterView1: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @State var formInputs = RegistrationFormInputs()
    @Environment (\.verticalSizeClass) var verticalSizeClass
    
    @State private var selectedTabIndex = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                HeaderViewComponent(headerModel: HeaderModel(headerType: .register1), frameSize: 100)
                NavigationLink {
                    RegisterSubView2(authViewModel: authViewModel, formInputs: $formInputs)
                } label: {
                    ButtonViewComponent(title: "Next", foregroundColor: .gray.opacity(0.3), titleColor: .accentColor)
                }
                .padding()
            }
            .onAppear {
                authViewModel.cleanCache()
            }
        }
    }
}

//    @ObservedObject var userViewModel: UserViewModel
//    @State var email: String = ""
//    @State var nickname: String = ""
//    @State var password: String = ""
//    @State var repeatPassword: String = ""
//    @State var thereIsError = false
//    
//    var body: some View {
//        VStack {
//            if verticalSizeClass == .compact {
//                HStack (spacing: 20){
//                    RegisterHeaderPart()
//                    Spacer()
//                    RegisterFormPart(authViewModel: authViewModel,
//                                     userViewModel: userViewModel,
//                                     email: $email,
//                                     nickname: $nickname,
//                                     password: $password,
//                                     repeatPassword: $repeatPassword,
//                                     thereIsError: $thereIsError)
//                }
//            }
//            else {
//                VStack {
//                    RegisterHeaderPart()
//                        .frame(height: 200)
//                    Spacer()
//                    RegisterFormPart(authViewModel: authViewModel,
//                                     userViewModel: userViewModel,
//                                     email: $email,
//                                     nickname: $nickname,
//                                     password: $password,
//                                     repeatPassword: $repeatPassword,
//                                     thereIsError: $thereIsError)
//                }
//            }
//            Spacer()
//        }
//        .alert(isPresented: $thereIsError) {
//            Alert(title: Text("Something went wrong"),
//                  message: Text(self.authViewModel.error ?? "Unknown error"),
//                  dismissButton: .default(Text("OK")))
//        }
//        .padding()
//    }
//}
//
//struct RegisterView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegisterView(authViewModel: AuthViewModel(), userViewModel: UserViewModel())
//    }
//}
