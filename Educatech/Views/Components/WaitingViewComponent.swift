//
//  WaitingViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 19/11/23.
//

import SwiftUI

/**
 A SwiftUI view component displaying a waiting animation along with informative text.

 - Note: This component is designed to show a waiting animation with a message during loading.
 - Parameters:
   - colorScheme: The color scheme environment variable used to adapt to light and dark mode.
 */
struct WaitingViewComponent: View {
    
    @Environment (\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(colorScheme == .light ? Color.white.opacity(0.9) : Color.black.opacity(0.7))
                .frame(width: 300, height: 300)
                .clipShape(.rect(cornerRadius: 10))
                .shadow(color: .gray, radius: 8, x: 0, y: 0)
                .overlay {
                    VStack {
                        WaitingAnimationViewComponent()
                        Text("Our elves are doing some magic tricks!")
                            .font(.title2)
                            .bold()
                            .padding()
                        Text("Please hold on! 🧚‍♀️")
                            .font(.title3)
                            .bold()
                            .padding()
                    }
                    .multilineTextAlignment(.center)
                }
        }
    }
}

#Preview {
    WaitingViewComponent()
}
