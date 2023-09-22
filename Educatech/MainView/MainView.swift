//
//  MainView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    
    @Environment (\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        
        let userEmail = authViewModel.user?.email ?? ""
        
        NavigationView {
            TabView {
                HomeView(email: userEmail)
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                SubscribedView()
                    .tabItem {
                        Label("My Lessons", systemImage: "text.book.closed")
                    }
//                TeachingView()
//                    .tabItem {
//                        Label("My teaching", systemImage: "graduationcap")
//                    }
                EditorView()
                    .tabItem {
                        Label("Editor", systemImage: "compass.drawing")
                    }
                ProfileView(authViewModel: authViewModel)
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    VStack {
                        SignoutButton(authViewModel: authViewModel)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Educatech")
                        .font(.system(size: verticalSizeClass == .compact ? 20 : 40, weight: .black, design: .rounded))
                        .foregroundColor(Color(.sRGB, red: 0.15, green: 0.50, blue: 0.75, opacity: 0.9))
                        .shadow(color: .cyan, radius: 2, x: 2, y: 2)                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(authViewModel: AuthViewModel())
    }
}
