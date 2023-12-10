//
//  SeparatorViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 23/10/23.
//

import SwiftUI

/**
 A SwiftUI view component representing a separator with horizontal rectangles and a centered dot.

 - Note: This separator is designed for visual separation in the user interface.
 */
struct SeparatorViewComponent: View {
    var body: some View {
        HStack {
            Rectangle()
            Text("o")
            Rectangle()
        }
        .foregroundStyle(.gray)
        .frame(height: 1)
        .ignoresSafeArea()
    }
}

#Preview {
    SeparatorViewComponent()
}
