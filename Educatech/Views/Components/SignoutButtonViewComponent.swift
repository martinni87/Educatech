//
//  SignoutButtonViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import SwiftUI

/// A SwiftUI view component for displaying a sign-out button.
/// - Parameter authViewModel: An observed object representing the authentication view model.
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
