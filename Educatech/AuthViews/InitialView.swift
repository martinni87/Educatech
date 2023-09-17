//
//  InitialView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import SwiftUI

struct InitialView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    
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
                        .foregroundColor(.gray.opacity(0.75))
                        .overlay {
                            NavigationLink {
                                LoginView(authViewModel: authViewModel)
                            } label: {
                                Text("Login with Email")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                        }
                    Rectangle()
                        .frame(width: 250, height: 40)
                        .cornerRadius(10)
                        .foregroundColor(.blue.opacity(0.75))
                        .overlay {
                            Button {
                                authViewModel.facebookLogin()
                            } label: {
                                Text("Login with Facebook")
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
                Text("Not a user?")
                Text("Register new email")
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
