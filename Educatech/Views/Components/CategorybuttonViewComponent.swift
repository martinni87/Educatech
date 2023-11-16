//
//  CategoryButtonViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 1/11/23.
//

import SwiftUI

struct CategoryButtonViewComponent: View {
    
    var selection: Categories
    @Binding var formInputs: RegistrationFormInputs
    @State var isSelected: Bool = false
    
    var body: some View {
        Button {
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
            if self.formInputs.categories.contains(selection.rawValue) {
                isSelected = true
            }
        }
    }
}

#Preview {
    CategoryButtonViewComponent(selection: .languageSwift, formInputs: .constant(RegistrationFormInputs()))
}
