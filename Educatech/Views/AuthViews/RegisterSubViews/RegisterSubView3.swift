//
//  RegisterSubView3.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 4/11/23.
//

import SwiftUI

/// A SwiftUI view component representing the third step of the registration process.
///
/// This view includes a selection of categories that the user can choose from. It provides a grid of category buttons for the user to select their interests.
///
/// - Parameters:
///   - authViewModel: The view model managing authentication.
///   - formInputs: Binding to the registration form inputs.
///   - verticalSizeClass: The vertical size class environment variable.
struct RegisterSubView3: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @Binding var formInputs: RegistrationFormInputs
    @Environment (\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        //MARK: Selectable categories
        NavigationStack {
            VStack {
                Spacer()
                HeaderViewComponent(headerModel: HeaderModel(headerType: .register3), frameSize: 70)
                Spacer()
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), alignment: .center)], alignment: .center, spacing: 16) {
                    ForEach(Categories.allCases, id: \.id) { category in
                        if category != .none {
                            CategoryButtonViewComponent(selection: category, formInputs: $formInputs)
                        }
                    }
                }
                Spacer()
                NavigationLink {
                    RegisterSubView4(authViewModel: authViewModel, formInputs: $formInputs)
                } label: {
                    ButtonViewComponent(title: "Next", foregroundColor: .gray.opacity(0.1), titleColor: .accentColor)
                }
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    RegisterSubView3(authViewModel: AuthViewModel(), formInputs: .constant(RegistrationFormInputs()))
}
