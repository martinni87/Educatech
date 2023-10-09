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
    
    @State var pageTitle = ""
    
    var body: some View {
        NavigationStack {
            TabView {
                HomeView(authViewModel: authViewModel, coursesViewModel: coursesViewModel)
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                    .onAppear {
                        pageTitle = "Home"
                    }
                SubscribedView()
                    .tabItem {
                        Label("My Lessons", systemImage: "text.book.closed")
                    }
                    .onAppear {
                        pageTitle = "My Lessons"
                    }
                EditorView(authViewModel: authViewModel, coursesViewModel: coursesViewModel)
                    .tabItem {
                        Label("Editor", systemImage: "compass.drawing")
                    }
                    .onAppear {
                        pageTitle = "Editor"
                    }
                ProfileView(authViewModel: authViewModel)
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
                    .onAppear {
                        pageTitle = "Profile"
                    }
            }
            .navigationTitle(pageTitle)
            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
////                ToolbarItem(placement: .topBarLeading) {
////                    Text("Educatech")
////                        .font(.system(size: verticalSizeClass == .compact ? 20 : 40, weight: .black, design: .rounded))
////                        .foregroundColor(Color(.sRGB, red: 0.15, green: 0.50, blue: 0.75, opacity: 0.9))
////                        .shadow(color: .cyan, radius: 2, x: 2, y: 2)
////                }
//                ToolbarItem(placement: .status) {
//                    HStack {
//                        Text("Welcome \(authViewModel.user?.email ?? "")")
//                        SignoutButton(authViewModel: authViewModel)
//                    }
//                }
//            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(authViewModel: AuthViewModel())
    }
}
