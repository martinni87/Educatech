//
//  RegisterView1.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import SwiftUI

import SwiftUI

/// The first step of the registration process in the Educatech app.
///
/// This view allows users to initiate the registration process by navigating to the next step of the registration flow.
///
/// - Parameters:
///   - authViewModel: The view model managing authentication.
///   - formInputs: The form inputs for the registration view.
///   - verticalSizeClass: The vertical size class environment variable.
struct RegisterView1: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @State var formInputs = RegistrationFormInputs()
    @Environment (\.verticalSizeClass) var verticalSizeClass
    
    @State private var selectedTabIndex = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                HeaderViewComponent(headerModel: HeaderModel(headerType: .register1), frameSize: 100)
                NavigationLink {
                    RegisterSubView2(authViewModel: authViewModel, formInputs: $formInputs)
                } label: {
                    ButtonViewComponent(title: "Next", foregroundColor: .gray.opacity(0.1), titleColor: .accentColor)
                }
                .padding()
            }
            .onAppear {
                authViewModel.cleanAll()
            }
        }
    }
}
