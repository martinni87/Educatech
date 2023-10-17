//
//  MainView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var authViewModel: AuthViewModel
    @StateObject var coursesViewModel: CoursesViewModel = CoursesViewModel()
    @StateObject var userViewModel: UserViewModel = UserViewModel()
    
    @Environment (\.verticalSizeClass) var verticalSizeClass
        
    var body: some View {
        NavigationStack {
            TabView {
                HomeView(authViewModel: authViewModel, coursesViewModel: coursesViewModel)
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                SubscribedView(authViewModel: authViewModel,
                               coursesViewModel: coursesViewModel,
                               userViewModel: userViewModel)
                .tabItem {
                    Label("My Lessons", systemImage: "text.book.closed")
                }
                EditorView(authViewModel: authViewModel, coursesViewModel: coursesViewModel)
                    .tabItem {
                        Label("Editor", systemImage: "compass.drawing")
                    }
                ProfileView(authViewModel: authViewModel)
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
            }
            .task {
                userViewModel.getUserByID(userID: authViewModel.user?.id ?? "8z38yBr08GTnTEXzLtEYi5r9grH3")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(authViewModel: AuthViewModel())
    }
}
