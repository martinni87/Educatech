//
//  EditorView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 22/9/23.
//

import SwiftUI
import PhotosUI

struct EditorView: View {
    
    @State var authViewModel: AuthViewModel
    @State var coursesViewModel: CoursesViewModel
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    CreateCourseView(authViewModel: $authViewModel, coursesViewModel: $coursesViewModel)
                } label: {
                    Label("Create a new course", systemImage: "doc.badge.plus")
                }

            }
        }
    }
}

struct EditorView_Previews: PreviewProvider {
    
    @State static var authViewModel: AuthViewModel = AuthViewModel()
    @State static var coursesViewModel: CoursesViewModel = CoursesViewModel()
    @State static var selectedItems: [PhotosPickerItem] = []
    
    static var previews: some View {
        EditorView(authViewModel: authViewModel, coursesViewModel: coursesViewModel)
    }
}
