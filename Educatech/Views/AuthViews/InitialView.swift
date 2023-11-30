//
//  InitialView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import SwiftUI

struct InitialView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @Environment (\.colorScheme) var colorScheme
    @Environment (\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        NavigationStack {
            HStack {
                Spacer()
                VStack {
                    HeaderViewComponent(headerModel: HeaderModel(headerType: .initial), frameSize: 150)
                        .padding(.top, 20)
                    Spacer()
                    NavigationLink {
                        LoginView(authViewModel: authViewModel)
                    } label: {
                        ProviderButtonViewComponent(provider: ProviderModel(colorScheme: colorScheme, type: .email))
                    }
                    Spacer()
                    NavigationLink {
                        RegisterView1(authViewModel: authViewModel)
                    } label: {
                        Text("Don't have an account yet?")
                            .foregroundColor(.white)
                        Text("Sign up")
                            .bold()
                    }
                    .padding(20)
                }
                Spacer()
            }
            .background(LinearGradient(colors: [.clear,
                                                .clear,
                                                .accentColor,
                                                .background,
                                                .black],
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing))
        }
        
    }
}

#Preview {
    InitialView(authViewModel: AuthViewModel())
}
