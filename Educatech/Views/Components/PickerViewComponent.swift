//
//  PickerViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 7/11/23.
//

import SwiftUI

struct PickerViewComponent: View {

    let label: String
    @Binding var variable: String
    @Environment (\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {

            Rectangle()
                .fill(colorScheme == .light ? .black.opacity(0.1) : .white.opacity(0.1))
                .frame(height: 40)
                .cornerRadius(10)
                .overlay {
                    HStack {
                        Text(label)
                            .foregroundColor(.gray)
                            .bold()
                        Spacer()
                        Picker("", selection: $variable) {
                            ForEach(Categories.allCases, id:\.id) { option in
                                Text(option.rawValue)
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
