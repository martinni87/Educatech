//
//  RegisterView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import SwiftUI

struct RegisterView: View {
    
    @Environment (\.verticalSizeClass) var verticalSizeClass
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var userViewModel: UserViewModel
    @State var email: String = ""
    @State var nickname: String = ""
    @State var password: String = ""
    @State var repeatPassword: String = ""
    @State var thereIsError = false
    
    var body: some View {
        VStack {
            if verticalSizeClass == .compact {
                HStack (spacing: 20){
                    RegisterHeaderPart()
                    Spacer()
                    RegisterFormPart(authViewModel: authViewModel,
                                     userViewModel: userViewModel,
                                     email: $email,
                                     nickname: $nickname,
                                     password: $password,
                                     repeatPassword: $repeatPassword,
                                     thereIsError: $thereIsError)
                }
            }
            else {
                VStack {
                    RegisterHeaderPart()
                        .frame(height: 200)
                    Spacer()
                    RegisterFormPart(authViewModel: authViewModel,
                                     userViewModel: userViewModel,
                                     email: $email,
                                     nickname: $nickname,
                                     password: $password,
                                     repeatPassword: $repeatPassword,
                                     thereIsError: $thereIsError)
                }
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
        RegisterView(authViewModel: AuthViewModel(), userViewModel: UserViewModel())
    }
}
