//
//  EditorView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 22/9/23.
//

import SwiftUI

struct EditorView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    CreateCourseView()
                } label: {
                    Label("Create a new course", systemImage: "doc.badge.plus")
                }

            }
        }
    }
}

struct EditorView_Previews: PreviewProvider {
    static var previews: some View {
        EditorView()
    }
}
