//
//  MainView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import SwiftUI

enum AppMainViews: String, Identifiable, CaseIterable {
    case home = "Home"
    case subscriptions = "Subscriptions"
    case search = "Search"
    case management = "Management"
    case profile = "Profile"
    
    var id: String {
        return rawValue
    }
}

let viewIcons: [AppMainViews: String] = [.home: "house",
                                         .subscriptions: "text.book.closed",
                                         .search: "magnifyingglass",
                                         .management: "pencil.and.outline",
                                         .profile: "person.fill"]

struct MainView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @State var pageTitle = "Educatech"
//    @State var showView = AppMainViews.home
//    @Environment (\.verticalSizeClass) var verticalSizeClass
//    @Environment (\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
//        //In case a user is using an iPad view shows as size menu with options
//        if verticalSizeClass == .regular && horizontalSizeClass == .regular {
//            NavigationView {
//                List {
//                    Rectangle()
//                        .fill(Color.clear)
//                        .frame(height: 30)
//                    ForEach(AppMainViews.allCases, id:\.id) { view in
//                        if view == .management && authViewModel.userData?.isEditor ?? false {
//                            Button {
//                                showView = view
//                            } label: {
//                                Label(view.rawValue, systemImage: viewIcons[view] ?? "")
//                            }
//                        }
//                        else if view != .management {
//                            Button {
//                                showView = view
//                            } label: {
//                                Label(view.rawValue, systemImage: viewIcons[view] ?? "")
//                            }
//                        }
//                    }
//                    .padding(10)
//                }
//                .foregroundStyle(Color.accentColor)
//                .bold()
//                .toolbar{
//                    ToolbarItem(placement: .topBarLeading) {
//                        VStack (alignment: .leading){
//                            Text("Educatech")
//                                .font(.system(size: 30, weight: .bold, design: .rounded))
//                                .foregroundColor(Color(.sRGB, red: 0.15, green: 0.50, blue: 0.75, opacity: 0.9))
//                                .shadow(color: .cyan, radius: 2, x: 2, y: 2)
//                            Text(pageTitle)
//                                .bold()
//                        }
//                    }
//                }
//                Group {
//                    switch showView {
//                    case .home:
//                        HomeView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
//                            .onAppear{
//                                pageTitle = "Home"
//                            }
//                    case .subscriptions:
//                        SubscribedView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
//                            .task {
//                                self.authViewModel.getCurrentUserData()
//                                self.collectionsViewModel.getCoursesByID(coursesIDs: authViewModel.userData?.subscriptions ?? [])
//                            }
//                            .onAppear{
//                                pageTitle = "Subscriptions"
//                            }
//                    case .search:
//                        SearchView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
//                            .onAppear{
//                                pageTitle = "Search"
//                            }
//                    case .management:
//                        if authViewModel.userData?.isEditor ?? false {
//                            ManagementView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
//                                .task {
//                                    self.authViewModel.getCurrentUserData()
//                                    self.collectionsViewModel.getCoursesByCreatorID(creatorID: authViewModel.userAuth?.id ?? "0")
//                                }
//                                .onAppear{
//                                    pageTitle = "Management Center"
//                                }
//                        }
//                    case .profile:
//                        ProfileView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
//                            .onAppear{
//                                pageTitle = "Profile"
//                            }
//                    }
//                }
//                .toolbar(.hidden)
//            }
//        }
//        //Other case user is using an iphone. View shows as tabs
//        else {
            NavigationStack {
                TabView {
                    HomeView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
                        .tabItem {
                            Label("Home", systemImage: viewIcons[.home]!)
                        }
//                        .task {
//                            self.authViewModel.getCurrentUserData()
//                            self.collectionsViewModel.getCoursesByCategories(categories: authViewModel.userData?.categories ?? [])
//                        }
                        .onAppear{
                            pageTitle = "Home"
                        }
                    
                    SubscribedView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
                        .tabItem {
                            Label("Subscriptions", systemImage: viewIcons[.subscriptions]!)
                        }
                        .task {
                            self.authViewModel.getCurrentUserData()
                            self.collectionsViewModel.getCoursesByID(coursesIDs: authViewModel.userData?.subscriptions ?? [])
                        }
                        .onAppear{
                            pageTitle = "Subscriptions"
                        }
                    
                    SearchView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
                        .tabItem {
                            Label("Search", systemImage: viewIcons[.search]!)
                        }
                        .onAppear{
                            pageTitle = "Search"
                        }
                    if authViewModel.userData?.isEditor ?? false {
                        ManagementView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
                            .tabItem {
                                Label("Management", systemImage: viewIcons[.management]!)
                            }
                            .onAppear{
                                pageTitle = "Management Center"
                            }
                            .task {
                                self.authViewModel.getCurrentUserData()
                                self.collectionsViewModel.getCoursesByCreatorID(creatorID: authViewModel.userAuth?.id ?? "0")
                            }
                    }
                    ProfileView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
                        .tabItem {
                            Label("Profile", systemImage: viewIcons[.profile]!)
                        }
                        .onAppear{
                            pageTitle = "Profile"
                        }
                }
                .navigationTitle(pageTitle)
                .navigationBarTitleDisplayMode(.inline)
//            }
        }
    }
}

#Preview {
    MainView(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel())
}
