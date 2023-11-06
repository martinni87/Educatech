//
//  CategoryButtonViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 1/11/23.
//

import SwiftUI

struct CategoryButtonViewComponent: View {
    
//    var selection: Categories
    var selection: String
    @Binding var formInputs: RegistrationFormInputs
    @State var isSelected: Bool = false
    
    var body: some View {
        Button {
            if self.formInputs.categories.contains(selection) {
                self.formInputs.categories.removeAll { $0 == selection }
            } else {
                self.formInputs.categories.append(selection)
            }
            isSelected.toggle()
            print("\(selection) is selected")
        } label: {
            Text(selection)
                .font(.title3)
                .bold()
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.capsule)
        .tint(isSelected ? .accentColor : .gray)
        .onAppear {
            if self.formInputs.categories.contains(selection) {
                isSelected = true
            }
        }
    }
}

#Preview {
    CategoryButtonViewComponent(selection: "Swift", formInputs: .constant(RegistrationFormInputs()))
}
