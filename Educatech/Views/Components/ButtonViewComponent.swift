//
//  ButtonViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 29/10/23.
//

import SwiftUI

/**
 A SwiftUI view component representing a customizable rectangular button.

 - Note: This view displays a button with configurable properties such as title, width, height, foreground color, and title color.
 - Parameters:
   - title: The text displayed on the button.
   - width: The width of the button.
   - height: The height of the button.
   - foregroundColor: The color of the button.
   - titleColor: The color of the text on the button.
 */
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
