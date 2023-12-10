//
//  BlackScreenPlayViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 11/11/23.
//

import SwiftUI

/// A SwiftUI view component that represents a black screen play button.
struct BlackScreenPlayViewComponent: View {
    var body: some View {
        ZStack {
            Rectangle().fill(Color.black).frame(width: 128, height: 80)
            Circle().fill(Color.white).frame(width: 50, height: 50)
            Image(systemName: "play.fill").scaleEffect(1.5).foregroundStyle(Color.black)
        }
        .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    BlackScreenPlayViewComponent()
}
