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
                NavigationLink {
                    LoginView(authViewModel: authViewModel)
                } label: {
                    Text("Login with email")
                }
                .buttonStyle(.borderedProminent)
                .tint(.gray.opacity(0.65))
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
