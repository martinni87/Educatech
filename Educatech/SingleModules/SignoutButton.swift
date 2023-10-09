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
            Label("Close session", systemImage: "power")
                .bold()
                .frame(maxWidth: .infinity)
        }
        .padding()
        .background(Color.pink)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
}

struct SignoutButton_Previews: PreviewProvider {
    static var previews: some View {
        SignoutButton(authViewModel: AuthViewModel())
    }
}
