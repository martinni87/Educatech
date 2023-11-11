//
//  HeaderViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 29/10/23.
//

import SwiftUI

struct HeaderViewComponent: View {
    
    @Environment (\.verticalSizeClass) var verticalSizeClass
    let headerModel: HeaderModel
    let frameSize: CGFloat
    
    var body: some View {
        VStack {
            Text(headerModel.title)
                .font(.system(
                    size: verticalSizeClass == .compact ? (headerModel.headerType == .initial ? 30.0 : 20.0) : (headerModel.headerType == .initial ? 50.0 : 35),
                    weight: headerModel.headerType == .initial ? .black : .bold,
                    design: headerModel.headerType == .initial ? .rounded : .default))
                .foregroundColor(headerModel.titleColor)
                .shadow(color: headerModel.headerType == .initial ? .cyan : .clear, radius: 2, x: 2, y: 2)
            if (verticalSizeClass == .regular  || headerModel.headerType == .register1 || headerModel.headerType == .register4) {
                VStack (spacing: 30) {
                    ZStack {
                        Image(headerModel.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: frameSize)
                            .scaleEffect(headerModel.headerType == .initial ? 1.2 : 1)
                        if headerModel.headerType == .initial {
                            Circle()
                                .stroke(lineWidth: 3)
                                .shadow(color: .cyan, radius: 5, x: 0, y: 0)
                                .foregroundColor(.accentColor)
                                .frame(width: 150, height: 150)
                        }
                    }
                    Text(headerModel.subtitle)
                        .bold()
                        .foregroundStyle(headerModel.subtitleColor)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                }
            }
        }
    }
}

#Preview {
    HeaderViewComponent(headerModel: HeaderModel(headerType: .initial), frameSize: 150)
}

#Preview {
    HeaderViewComponent(headerModel: HeaderModel(headerType: .register4), frameSize: 80)
}
