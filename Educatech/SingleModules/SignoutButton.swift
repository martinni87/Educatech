//
//  SignoutButton.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import SwiftUI

struct SignoutButton: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        Button("Sign out"){
            authViewModel.signOut()
        }
        .tint(.pink)
        .padding(10)
        .buttonStyle(.bordered)
    }
}

struct SignoutButton_Previews: PreviewProvider {
    static var previews: some View {
        SignoutButton(authViewModel: AuthViewModel())
    }
}
