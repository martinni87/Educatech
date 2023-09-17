//
//  InitialView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import SwiftUI
import FacebookLogin

struct InitialView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @Environment (\.colorScheme) var colorScheme

    var body: some View {
        NavigationStack {
            Spacer()
            VStack {
                Text("Educatech")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                VStack {
                    Rectangle()
                        .frame(width: 250, height: 40)
                        .cornerRadius(10)
                        .foregroundColor(colorScheme == .light ? .mint : .teal.opacity(0.75))
                        .overlay {
                            NavigationLink {
                                LoginView(authViewModel: authViewModel)
                            } label: {
                                Text("Login with Email")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        }
                    HStack {
                        Rectangle()
                            .frame(height: 1)
                        Text("or")
                        Rectangle().frame(height: 1)
                    }
                    .foregroundColor(.gray)
                    .padding(30)
                    Rectangle()
                        .frame(width: 250, height: 40)
                        .cornerRadius(10)
                        .foregroundColor(.blue.opacity(0.75))
                        .overlay {
                            Button {
                                authViewModel.facebookLogin()
                            } label: {
                                Text("Continue with Facebook")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        }
                    
                }
                Spacer()
            }
            Spacer()
            NavigationLink {
                RegisterView(authViewModel: authViewModel)
            } label: {
                Text("Don't have an account yet?")
                    .foregroundColor(.black)
                Text("Sign up")
                    .bold()
            }
        }
    }
}



struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView(authViewModel: AuthViewModel())
    }
}
