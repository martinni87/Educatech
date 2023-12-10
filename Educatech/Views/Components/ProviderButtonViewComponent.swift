//
//  ProviderButtonViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 23/10/23.
//

import SwiftUI

/**
 A SwiftUI view component representing a button for a specific authentication provider.

 - Note: This view displays a rectangular button with an icon and text for accessing authentication with a particular provider.
 - Parameter provider: The data model representing the authentication provider.
 */
struct ProviderButtonViewComponent: View {
    
    let provider: ProviderModel /// The data model for the authentication provider.
    
    var body: some View {
        Rectangle()
            .fill(provider.backgroundColor)
            .frame(width: 300, height: 40, alignment: .center)
            .cornerRadius(8, antialiased: true)
            .overlay{
                HStack{
                    Image(provider.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                        .padding(.leading, 15)
                    Spacer()
                    Text("Access with \(provider.title)")
                        .foregroundColor(provider.titleColor)
                        .bold()
                        Spacer()
                }
            }
    }
}

#Preview {
    ProviderButtonViewComponent(provider: ProviderModel(colorScheme: ColorScheme.light, type: .email))
}
