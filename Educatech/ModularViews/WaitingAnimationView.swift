//
//  WaitingAnimationView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 7/10/23.
//

//import SwiftUI
//
//struct WaitingAnimationView: View {
//    
//    @State var rotationAngle: Double = 0.0
//
//    var body: some View {
//        HStack {
//            Spacer()
//            Image("loading") //Loading picture until online picture is loaded
//                .resizable()
//                .scaledToFit()
//                .frame(height: 35)
//                .rotationEffect(.degrees(rotationAngle))
//                .onAppear {
//                    withAnimation(Animation.linear(duration: 2.0).repeatForever(autoreverses: false)) {
//                        rotationAngle = 360
//                    }
//                }
//            Spacer()
//        }
//    }
//}
//
//#Preview {
//    WaitingAnimationView()
//}
