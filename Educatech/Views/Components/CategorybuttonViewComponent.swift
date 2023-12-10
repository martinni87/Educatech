//
//  CategoryButtonViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 1/11/23.
//

import SwiftUI

/// A SwiftUI view component for displaying a button representing a category selection.
///
/// - Parameters:
///   - selection: The category represented by the button.
///   - formInputs: A binding to the registration form inputs, including selected categories.
///   - isSelected: A state variable indicating whether the category is currently selected.
struct CategoryButtonViewComponent: View {
    
    var selection: Categories
    @Binding var formInputs: RegistrationFormInputs
    @State var isSelected: Bool = false
    
    var body: some View {
        Button {
            // Toggle category selection and update state
            if self.formInputs.categories.contains(selection.rawValue) {
                self.formInputs.categories.removeAll { $0 == selection.rawValue }
            } else {
                self.formInputs.categories.append(selection.rawValue)
            }
            isSelected.toggle()
            print("\(selection) is selected")
        } label: {
            Text(selection.rawValue)
                .font(.title3)
                .bold()
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.capsule)
        .tint(isSelected ? .accentColor : .gray)
        .onAppear {
            // Set initial selection state
            if self.formInputs.categories.contains(selection.rawValue) {
                isSelected = true
            }
        }
    }
}

#Preview {
    CategoryButtonViewComponent(selection: .languageSwift, formInputs: .constant(RegistrationFormInputs()))
}
