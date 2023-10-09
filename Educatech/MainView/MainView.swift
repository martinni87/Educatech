//
//  MainView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var coursesViewModel: CoursesViewModel = CoursesViewModel()

    @Environment (\.verticalSizeClass) var verticalSizeClass
    
//    @State var pageTitle = ""
    
    var body: some View {
        NavigationStack {
            TabView {
                HomeView(authViewModel: authViewModel, coursesViewModel: coursesViewModel)
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
//                    .onAppear {
//                        pageTitle = "Home"
//                    }
                SubscribedView()
                    .tabItem {
                        Label("My Lessons", systemImage: "text.book.closed")
                    }
//                    .onAppear {
//                        pageTitle = "My Lessons"
//                    }
                EditorView(authViewModel: authViewModel, coursesViewModel: coursesViewModel)
                    .tabItem {
                        Label("Editor", systemImage: "compass.drawing")
                    }
//                    .onAppear {
//                        pageTitle = "Editor"
//                    }
                ProfileView(authViewModel: authViewModel)
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
//                    .onAppear {
//                        pageTitle = "Profile"
//                    }
            }
//            .navigationTitle(pageTitle)
//            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(authViewModel: AuthViewModel())
    }
}
