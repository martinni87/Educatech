//
//  SeparatorViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 23/10/23.
//

import SwiftUI

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
