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
        Button {
            authViewModel.signOut()
        } label: {
            Image(systemName: "power")
        }
        .font(.system(size: 15))
        .tint(.pink.opacity(0.5))
    }
}

struct SignoutButton_Previews: PreviewProvider {
    static var previews: some View {
        SignoutButton(authViewModel: AuthViewModel())
    }
}
