//
//  ProfileView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 20/9/23.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @State var showLinkEmailForm = false
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Form {
                    Section("Link Providers") {
                        Button {
                            showLinkEmailForm.toggle()
                        } label: {
                            HStack {
                                Image("logo_email")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 25)
                                    .padding(.trailing, 10)
                                Text("Link email")
                            }
                        }
                        .disabled(authViewModel.isEmailAndPasswordLinked())
                        
                        Button {
                            authViewModel.linkFacebook()
                        } label: {
                            HStack {
                                Image("logo_facebook")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 25)
                                    .padding(.trailing, 10)
                                Text("Link Facebook")
                            }
                        }
                        .disabled(authViewModel.isFacebookLinked())
                        
                        Button {
                            authViewModel.linkGoogle()
                        } label: {
                            HStack {
                                Image("logo_google")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 25)
                                    .padding(.trailing, 10)
                                Text("Link Google")
                            }
                        }
                        .disabled(authViewModel.isGoogleLinked())
                        
                    }
                }
                .alert("Link provider", isPresented: $authViewModel.showAlert) {
                    Button("Aceptar") {
                        print("Dismiss")
                    }
                } message: {
                    if authViewModel.didLinkedAccount {
                        Text("Your account has been linked")
                    }
                    else {
                        Text("Something went wrong. Try again later or contact the sysadmin")
                    }
                }
                
                if showLinkEmailForm {
                    VStack (alignment: .center) {
                        Form {
                            Section ("Link email") {
                                TextField("Email", text: $email)
                                SecureField("Password", text: $password)
                            }
                            Button {
                                authViewModel.linkEmailAndPassword(email: email, password: password)
                                showLinkEmailForm.toggle()
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("Link")
                                    Spacer()
                                }
                            }
                            .tint(.green)
                        }
                    }
                    .frame(width: 250, height: 250)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                }
                
            }
            .navigationTitle("Profile")
        }
        .task {
            authViewModel.getCurrentProvider()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(authViewModel: AuthViewModel())
    }
}
