//
//  ProviderButtonViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 23/10/23.
//

import SwiftUI

struct ProviderButtonViewComponent: View {
    
    let provider: ProviderModel
    
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
