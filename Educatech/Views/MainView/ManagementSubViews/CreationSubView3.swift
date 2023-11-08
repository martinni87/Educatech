//
//  CreationSubView3.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 7/11/23.
//

import SwiftUI

struct CreationSubView3: View {
    var body: some View {
        NavigationStack {
            HeaderViewComponent(headerModel: HeaderModel(headerType: .createcourse3), frameSize: 70)
            Spacer()
            Text("add videos to the course")
            Spacer()
            NavigationLink {
                CreationSubView4()
            } label: {
                ButtonViewComponent(title: "Next", foregroundColor: .gray.opacity(0.3), titleColor: .accentColor)
            }
        }
    }
}

#Preview {
    CreationSubView3()
}
