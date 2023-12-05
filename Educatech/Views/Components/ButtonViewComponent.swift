//
//  ButtonViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 29/10/23.
//

import SwiftUI

struct ButtonViewComponent: View {
    
    let title: String
    var width: CGFloat = 150
    var height: CGFloat = 40
    var foregroundColor: Color = .accentColor
    var titleColor: Color = .white
    
    @Environment (\.colorScheme) var colorScheme
    
    var body: some View {
        Rectangle()
            .fill(foregroundColor)
            .frame(width: width, height: height, alignment: .center)
            .cornerRadius(8, antialiased: true)
            .shadow(color: .gray, radius: 5, x: 0, y: 0)
            .overlay {
                Text(title)
                    .foregroundStyle(titleColor)
                    .bold()
            }
    }
}

#Preview {
    ButtonViewComponent(title: "Example", width: 150, height: 50)
}
