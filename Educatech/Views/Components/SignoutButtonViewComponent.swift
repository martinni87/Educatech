//
//  SignoutButtonViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import SwiftUI

struct SignoutButtonViewComponent: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        HStack {
            Button {
                authViewModel.signOut()
            } label: {
                Label("Close session", systemImage: "power")
                    .bold()
            }
            .foregroundColor(.pink)
        }
    }
}

#Preview {
    SignoutButtonViewComponent(authViewModel: AuthViewModel())
}
