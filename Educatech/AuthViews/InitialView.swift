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
    @Environment (\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        NavigationStack {
            Spacer()
            VStack {
                Text("Educatech")
                    .font(.largeTitle)
                    .bold()
                if verticalSizeClass == .regular {
                    Circle()
                        .stroke(lineWidth: 3)
                        .foregroundColor(.accentColor)
                        .frame(width: 150, height: 150)
                        .overlay {
                            Image("logo_app")
                                .resizable()
                                .scaleEffect(1.2)
                                .scaledToFit()
                        }
                        .padding()
                }
                Spacer()
                VStack {
                    Rectangle()
                        .frame(width: 280, height: 40)
                        .cornerRadius(10)
                        .foregroundColor(colorScheme == .light ? .mint : .teal.opacity(0.75))
                        .overlay {
                            NavigationLink {
                                LoginView(authViewModel: authViewModel)
                            } label: {
                                Image("logo_email")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                                    .padding(.leading, 15)
                                Spacer()
                                Text("Sign in with Email")
                                    .foregroundColor(.white)
                                    .bold()
                                Spacer()
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
                        .frame(width: 280, height: 40)
                        .cornerRadius(10)
                        .foregroundColor(Color("color_facebook"))
                        .overlay {
                            Button {
                                authViewModel.facebookLogin()
                            } label: {
                                Image("logo_facebook")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                                    .padding(.leading, 15)
                                Spacer()
                                Text("Continue with Facebook")
                                    .foregroundColor(.white)
                                    .bold()
                                Spacer()
                            }
                        }
                    Rectangle()
                        .frame(width: 280, height: 40)
                        .cornerRadius(10)
                        .foregroundColor(.gray.opacity(0.25))
                        .overlay {
                            Button {
                                authViewModel.googleLogin()
                            } label: {
                                Image("logo_google")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                                    .padding(.leading, 15)
                                Spacer()
                                Text("Continue with Google")
                                    .foregroundColor(colorScheme == .light ? .black : .white)
                                    .bold()
                                Spacer()
                            }
                        }
                    Rectangle()
                        .frame(width: 280, height: 40)
                        .cornerRadius(10)
                        .foregroundColor(colorScheme == .light ? .black : .white)
                        .overlay {
                            NavigationLink {
                                VStack (spacing: 20){
                                    Label("Apple login", systemImage: "apple.logo")
                                        .font(.largeTitle)
                                        .bold()
                                    Text("Coming soon on next update...")
                                    Text("Thanks for your patience 🍀")
                                }
                            } label: {
                                Image("logo_apple")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                                    .padding(.leading, 15)
                                Spacer()
                                Text("Continue with Apple")
                                    .foregroundColor(colorScheme == .light ? .white : .black)
                                    .bold()
                                Spacer()
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
