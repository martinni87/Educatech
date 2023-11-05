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
            NavigationLink ("Login") {
                LoginView(authViewModel: authViewModel)
            }
            NavigationLink ("Register") {
                RegisterView(authViewModel: authViewModel)
            }
        }
    }
}

//    @ObservedObject var authViewModel: AuthViewModel
//    @StateObject var userViewModel: UserViewModel = UserViewModel()
//    @Environment (\.colorScheme) var colorScheme
//    @Environment (\.verticalSizeClass) var verticalSizeClass
//    
//    var body: some View {
//        NavigationStack {
//            Spacer()
//            VStack {
//                Text("Educatech")
//                    .font(.system(size: verticalSizeClass == .compact ? 30.0 : 50.0, weight: .black, design: .rounded))
//                    .foregroundColor(Color(.sRGB, red: 0.15, green: 0.50, blue: 0.75, opacity: 0.9))
//                    .shadow(color: .cyan, radius: 2, x: 2, y: 2)
//                    .bold()
//                if verticalSizeClass == .regular {
//                    Circle()
//                        .stroke(lineWidth: 3)
//                        .shadow(color: .cyan, radius: 5, x: 0, y: 0)
//                        .foregroundColor(.accentColor)
//                        .frame(width: 150, height: 150)
//                        .overlay {
//                            Image("logo_app")
//                                .resizable()
//                                .scaleEffect(1.2)
//                                .scaledToFit()
//                        }
//                        .padding()
//                }
//                Spacer()
//                VStack {
//                    Rectangle()
//                        .frame(width: 280, height: 40)
//                        .cornerRadius(10)
//                        .foregroundColor(colorScheme == .light ? .mint : .teal.opacity(0.75))
//                        .overlay {
//                            NavigationLink {
//                                LoginView(authViewModel: authViewModel, userViewModel: userViewModel)
//                            } label: {
//                                Image("logo_email")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 20)
//                                    .padding(.leading, 15)
//                                Spacer()
//                                Text("Sign in with Email")
//                                    .foregroundColor(.white)
//                                    .bold()
//                                Spacer()
//                            }
//                        }
//                    HStack {
//                        Rectangle()
//                            .frame(height: 1)
//                        Text("or")
//                        Rectangle().frame(height: 1)
//                    }
//                    .foregroundColor(.gray)
//                    .padding(verticalSizeClass == .compact ? 15 : 30)
//                    Rectangle()
//                        .frame(width: 280, height: 40)
//                        .cornerRadius(10)
//                        .foregroundColor(Color("color_facebook"))
//                        .overlay {
//                            Button {
//                                authViewModel.facebookLogin(userViewModel: userViewModel)
//                            } label: {
//                                Image("logo_facebook")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 20)
//                                    .padding(.leading, 15)
//                                Spacer()
//                                Text("Continue with Facebook")
//                                    .foregroundColor(.white)
//                                    .bold()
//                                Spacer()
//                            }
//                        }
//                    Rectangle()
//                        .frame(width: 280, height: 40)
//                        .cornerRadius(10)
//                        .foregroundColor(.gray.opacity(0.25))
//                        .overlay {
//                            Button {
//                                authViewModel.googleLogin(userViewModel: userViewModel)
//                            } label: {
//                                Image("logo_google")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 20)
//                                    .padding(.leading, 15)
//                                Spacer()
//                                Text("Continue with Google")
//                                    .foregroundColor(colorScheme == .light ? .black : .white)
//                                    .bold()
//                                Spacer()
//                            }
//                        }
//                    Rectangle()
//                        .frame(width: 280, height: 40)
//                        .cornerRadius(10)
//                        .foregroundColor(colorScheme == .light ? .black : .white)
//                        .overlay {
//                            NavigationLink {
//                                VStack (spacing: 20){
//                                    Label("Apple login", systemImage: "apple.logo")
//                                        .font(.largeTitle)
//                                        .bold()
//                                    Text("Coming soon on next update...")
//                                    Text("Thanks for your patience 🍀")
//                                }
//                            } label: {
//                                Image("logo_apple")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 20)
//                                    .padding(.leading, 15)
//                                Spacer()
//                                Text("Continue with Apple")
//                                    .foregroundColor(colorScheme == .light ? .white : .black)
//                                    .bold()
//                                Spacer()
//                            }
//                        }
//                    
//                }
//                Spacer()
//            }
//            Spacer()
//            NavigationLink {
//                RegisterView(authViewModel: authViewModel, userViewModel: userViewModel)
//            } label: {
//                Text("Don't have an account yet?")
//                    .foregroundColor(colorScheme == .light ? .black : .white)
//                Text("Sign up")
//                    .bold()
//            }
//            .padding(.bottom, verticalSizeClass == .compact ? 20 : 0)
//        }
//    }
//}
//
//
//
//struct InitialView_Previews: PreviewProvider {
//    static var previews: some View {
//        InitialView(authViewModel: AuthViewModel(), userViewModel: UserViewModel())
//    }
//}
