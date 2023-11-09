//
//  MainView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @State var pageTitle = "Educatech"
    
    var body: some View {
        NavigationStack {
            TabView {
                HomeView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .onAppear{
                    pageTitle = "Home"
                }
                
                SubscribedView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
                .tabItem {
                    Label("My Lessons", systemImage: "text.book.closed")
                }
                .onAppear{
                    pageTitle = "My Lessons"
                }
                
                SearchView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .onAppear{
                    pageTitle = "Search"
                }
                if authViewModel.userData?.isEditor ?? false {
                    ManagementView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
                    .tabItem {
                        Label("Management", systemImage: "pencil.and.outline")
                    }
                    .onAppear{
                        pageTitle = "Management Center"
                    }
                }
                ProfileView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
                    .onAppear{
                        pageTitle = "Profile"
                    }
            }
            .navigationTitle(pageTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MainView(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel())
}
//
//    @ObservedObject var authViewModel: AuthViewModel
//    @StateObject var coursesViewModel: CoursesViewModel = CoursesViewModel()
//    @StateObject var userViewModel: UserViewModel = UserViewModel()
//
//    @State var pageTitle = "Educatech"
//
//    @Environment (\.verticalSizeClass) var verticalSizeClass
//
//    var body: some View {
//        NavigationStack {
//            TabView {
//                HomeView(authViewModel: authViewModel,
//                         coursesViewModel: coursesViewModel,
//                         userViewModel: userViewModel)
//                .tabItem {
//                    Label("Home", systemImage: "house.fill")
//                }
//                .onAppear{
//                    pageTitle = "Home"
//                }
//
//                SubscribedView(authViewModel: authViewModel,
//                               coursesViewModel: coursesViewModel,
//                               userViewModel: userViewModel)
//                .tabItem {
//                    Label("My Lessons", systemImage: "text.book.closed")
//                }
//                .onAppear{
//                    pageTitle = "My Lessons"
//                }
//
//                SearchView(authViewModel: authViewModel,
//                           coursesViewModel: coursesViewModel,
//                           userViewModel: userViewModel)
//                .tabItem {
//                    Label("Search", systemImage: "magnifyingglass")
//                }
//                .onAppear{
//                    pageTitle = "Search"
//                }
//
//                ManagementView(authViewModel: authViewModel,
//                               coursesViewModel: coursesViewModel)
//                .tabItem {
//                    Label("Management", systemImage: "pencil.and.outline")
//                }
//                .onAppear{
//                    pageTitle = "Courses Management"
//                }
//
//                ProfileView(authViewModel: authViewModel)
//                    .tabItem {
//                        Label("Profile", systemImage: "person.fill")
//                    }
//                    .onAppear{
//                        pageTitle = "Profile"
//                    }
//            }
//            .navigationTitle(pageTitle)
//            .navigationBarTitleDisplayMode(.inline)
//            .task{
//                print(userViewModel.user?.id ?? "No id")
//                print(userViewModel.user?.email ?? "No email")
//                print(userViewModel.user?.nickname ?? "No nickname")
//                print(userViewModel.user?.subscriptions ?? ["Empty"])
//            }
//        }
//    }
//}
//
//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView(authViewModel: AuthViewModel(), coursesViewModel: CoursesViewModel(), userViewModel: UserViewModel())
//    }
//}
