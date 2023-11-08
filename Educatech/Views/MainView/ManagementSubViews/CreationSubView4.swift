//
//  CreationSubView4.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 8/11/23.
//

import SwiftUI

struct CreationSubView4: View {
    var body: some View {
        HeaderViewComponent(headerModel: HeaderModel(headerType: .createcourse4), frameSize: 70)
        Spacer()
        Text("check list")
        Spacer()
        Button {
            print("Create new course")
        } label: {
            ButtonViewComponent(title: "Create")
        }
        .padding(.top,20)
        .padding(.bottom, 50)
    }
}

#Preview {
    CreationSubView4()
}
