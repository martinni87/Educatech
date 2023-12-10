//
//  WaitingAnimationViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 7/10/23.
//

import SwiftUI

/// A SwiftUI view component for displaying a waiting animation.
///
/// - Parameters:
///   - rotationAngle: The rotation angle of the animation.
struct WaitingAnimationViewComponent: View {

    @State var rotationAngle: Double = 0.0

    var body: some View {
        HStack {
            Spacer()
            Image("AppWaitingRoullette") //Loading picture until online picture is loaded
                .resizable()
                .scaledToFit()
                .frame(height: 35)
                .rotationEffect(.degrees(rotationAngle))
                .onAppear {
                    // Animate rotation continuously
                    withAnimation(Animation.linear(duration: 2.0).repeatForever(autoreverses: false)) {
                        rotationAngle = 360
                    }
                }
            Spacer()
        }
    }
}

#Preview {
    WaitingAnimationViewComponent()
}
