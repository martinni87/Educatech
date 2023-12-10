//
//  PickerViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 7/11/23.
//

import SwiftUI

/// The use case for the Picker in different views.
enum UseCases {
    case courseCreationEdition
    case searchBarItem
    case userCategory
}

/**
 A SwiftUI view component for displaying and selecting values using a Picker.
 
 - Note: This view includes a Picker with different use cases such as course creation/edition, search bar item, and user category.
 - Parameters:
   - label: The label to display above the Picker.
   - variable: Binding to the selected value.
   - useCase: The use case for the Picker, determining the available options.
 */
struct PickerViewComponent: View {

    let label: String
    @Binding var variable: String
    @State var useCase: UseCases = .userCategory
    @Environment (\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            Rectangle()
                .fill(colorScheme == .light ? .black.opacity(0.1) : .white.opacity(0.1))
                .frame(height: 40)
                .frame(maxWidth: 850)
                .cornerRadius(10)
                .overlay {
                    HStack {
                        Text(label)
                            .foregroundColor(.gray)
                            .bold()
                        Spacer()
                        Picker("", selection: $variable) {
                            ForEach(Categories.allCases, id:\.id) { option in
                                if option == .none {
                                    switch useCase {
                                    case .courseCreationEdition, .userCategory:
                                        Text("Not selected")
                                    case .searchBarItem:
                                        Text("All")
                                    }
                                }
                                else {
                                    Text(option.rawValue)
                                }
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    .padding(.horizontal)
                }
        }
    }
}

#Preview {
    PickerViewComponent(label: "Titulo", variable: .constant(""))
}
