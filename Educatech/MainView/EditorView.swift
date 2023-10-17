//
//  EditorView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 22/9/23.
//

import SwiftUI
import PhotosUI

struct EditorView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var coursesViewModel: CoursesViewModel
    
    var body: some View {
        NavigationStack {
            Text("Editor")
                .bold()
                .font(.headline)
            List {
                NavigationLink {
                    CreateCourseView(authViewModel: authViewModel, coursesViewModel: coursesViewModel)
                } label: {
                    Label("Create a new course", systemImage: "doc.badge.plus")
                }
                NavigationLink {
                    ManagerCourseView(authViewModel: authViewModel, coursesViewModel: coursesViewModel)
                } label: {
                    Label("My managed courses", systemImage: "text.book.closed")
                }
            }
//            .navigationTitle("Editor")
//            .navigationBarTitleDisplayMode(.inline)
            .task(priority: .high) {
                coursesViewModel.getCoursesByCreatorID(creatorID: authViewModel.user?.id ?? "8z38yBr08GTnTEXzLtEYi5r9grH3")
            }
        }
    }
}

struct EditorView_Previews: PreviewProvider {
    
    @State static var authViewModel: AuthViewModel = AuthViewModel()
    @State static var coursesViewModel: CoursesViewModel = CoursesViewModel()
    
    static var previews: some View {
        EditorView(authViewModel: authViewModel, coursesViewModel: coursesViewModel)
    }
}
