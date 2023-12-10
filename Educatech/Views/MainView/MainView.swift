//
//  MainView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import SwiftUI
import MessageUI

/// Enum representing the main views of the Educatech app.
enum AppMainViews: String, Identifiable, CaseIterable {
    case home = "Home"
    case subscriptions = "Subscriptions"
    case search = "Search"
    case management = "My teachings"
    case profile = "Profile"
    
    /// Computed property returning the raw value of the enum case, used as the identifier.
    var id: String {
        return rawValue
    }
}

/// Enum representing different device types.
enum Devices {
    case iphone, ipad
}

/// Dictionary mapping AppMainViews to their corresponding SF Symbols for tab icons.
/// Each view has a corresponding SF Symbol name associated with it for display in the tab bar.
let viewIcons: [AppMainViews: String] = [.home: "house.fill",
                                         .subscriptions: "star.fill",
                                         .search: "magnifyingglass",
                                         .management: "graduationcap.fill",
                                         .profile: "person.fill"]

/// Represents the main view of the Educatech app, providing navigation and content based on the selected tab.
///
/// - Parameters:
///   - authViewModel: An observed object representing the authentication view model.
///   - collectionsViewModel: An observed object representing the collections view model.
///   - pageTitle: State variable holding the title displayed at the top of the main view.
///   - activeView: State variable holding an instance of `AppMainViews` enum, indicating the current tab.
///   - isNewSearch: State variable indicating whether a new search is being performed in the Search view.
///   - selection: State variable holding the selected category for searching in the Search view.
///   - sendEmailResult: State variable holding the result of sending an email through the email composer.
///   - errorContactSupport: State variable indicating whether an error occurred during support email.
///   - isShowingEmailView: State variable indicating whether the email composer view is visible.
///   - emailBody: State variable holding the text content of the email to be sent.
///   - emailData: State variable holding an optional instance of `EmailDataModel` for additional email data.
///   - device: State variable representing the type of device (iPhone or iPad).
///   - verticalSizeClass: Environment variable representing the vertical size class (compact or regular).
///   - horizontalSizeClass: Environment variable representing the horizontal size class (compact or regular).
///
/// - Returns: A SwiftUI view representing the main navigation and content of the Educatech app.

struct MainView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    
    @State var pageTitle = "Educatech"
    @State var activeView: AppMainViews = .home
    @State var isNewSearch: Bool = true
    @State var selection: String = ""
    
    @State var sendEmailResult: Result<MFMailComposeResult, Error>? = nil
    @State var errorContactSupport = false
    @State var isShowingEmailView = false
    @State var emailBody: String = ""
    @State var emailData: EmailDataModel?
    
    @State var device: Devices = .iphone
    @Environment (\.verticalSizeClass) var verticalSizeClass
    @Environment (\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        NavigationStack {
            //Header shows different elements if its on iPhone or iPad
            VStack {
                //In case of iPhone, show title and special buttons in profile
                if device == .iphone {
                    VStack {
                        HStack {
                            Text(pageTitle).font(.system(size: 16, weight: .black, design: .rounded))
                                .padding(.top)
                            if activeView == .profile {
                                Spacer()
                                HStack {
                                    MailButtonViewComponent(authViewModel: authViewModel,
                                                            sendEmailResult: $sendEmailResult,
                                                            errorContactSupport: $errorContactSupport,
                                                            isShowingEmailView: $isShowingEmailView,
                                                            emailBody: $emailBody,
                                                            emailData: $emailData)
                                    SignoutButtonViewComponent(authViewModel: authViewModel)
                                        .labelStyle(.iconOnly)
                                }
                                .padding(.top)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                //In case of iPad, show menu with tab buttons, won't show bottom bar
                else if device == .ipad {
                    HStack (spacing: 20) {
                        Button {
                            activeView = .home
                        } label: {
                            Label("Home", systemImage: viewIcons[.home]!)
                                .disabled(activeView != .home)
                        }
                        Button {
                            activeView = .subscriptions
                        } label: {
                            Label("Subscriptions", systemImage: viewIcons[.subscriptions]!)
                                .disabled(activeView != .subscriptions)
                        }
                        Button {
                            activeView = .search
                        } label: {
                            Label("Search", systemImage: viewIcons[.search]!)
                                .disabled(activeView != .search)
                        }
                        if authViewModel.userData?.isEditor ?? false {
                            Button {
                                activeView = .management
                            } label: {
                                Label("My teachings", systemImage: viewIcons[.management]!)
                                    .disabled(activeView != .management)
                            }
                        }
                        Spacer()
                        Button {
                            activeView = .profile
                        } label: {
                            Label("Profile", systemImage: "person.crop.circle.fill")
                                .labelStyle(.iconOnly)
                                .disabled(activeView != .profile)
                        }
                        if activeView == .profile {
                            HStack {
                                MailButtonViewComponent(authViewModel: authViewModel,
                                                        sendEmailResult: $sendEmailResult,
                                                        errorContactSupport: $errorContactSupport,
                                                        isShowingEmailView: $isShowingEmailView,
                                                        emailBody: $emailBody,
                                                        emailData: $emailData)
                                SignoutButtonViewComponent(authViewModel: authViewModel)
                                    .labelStyle(.iconOnly)
                            }
                        }
                    }
                    .font(.system(size: 20))
                    .bold()
                    .padding()
                }
                //For every case, in search view show the search bar by category
                if activeView == .search {
                    PickerViewComponent(label: "Category to search:", variable: $selection, useCase: .searchBarItem)
                        .onAppear {
                            collectionsViewModel.getCoursesByCategory(category: selection)
                            isNewSearch = false
                        }
                        .onChange(of: selection) { _, newValue in
                            collectionsViewModel.getCoursesByCategory(category: selection)
                            isNewSearch = false
                        }
                        .padding(.horizontal)
                }
                //For every case use a line as separator
                Rectangle().fill(Color.accentColor).frame(height: 1)
                    .ignoresSafeArea()
            }
            .foregroundStyle(Color.accentColor)
            .background(Color.background)
            
            // Active views. Activated when a tab button is pressed
            VStack {
                switch activeView {
                case .home:
                    HomeView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
                        .onAppear{
                            pageTitle = activeView.rawValue
                            collectionsViewModel.getAllCourses()
                            collectionsViewModel.getSubscribedCoursesByID(coursesIDs: authViewModel.userData?.subscriptions ?? [])
                        }
                case .subscriptions:
                    SubscribedView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
                        .task {
                            self.authViewModel.getCurrentUserData()
                            self.collectionsViewModel.getSubscribedCoursesByID(coursesIDs: authViewModel.userData?.subscriptions ?? [])
                        }
                        .onAppear{
                            pageTitle = activeView.rawValue
                        }
                    
                case .search:
                    SearchView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel, isNewSearch: $isNewSearch, selection: $selection)
                        .onAppear{
                            pageTitle = activeView.rawValue
                        }
                case .management:
                    ManagementView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
                        .onAppear{
                            pageTitle = activeView.rawValue
                        }
                        .task {
                            self.authViewModel.getCurrentUserData()
                            self.collectionsViewModel.getCoursesByCreatorID(creatorID: authViewModel.userAuth?.id ?? "0")
                        }
                case .profile:
                    ProfileView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel, sendEmailResult: $sendEmailResult, errorContactSupport: $errorContactSupport, isShowingEmailView: $isShowingEmailView, emailBody: $emailBody, emailData: $emailData)
                        .task {
                            self.authViewModel.getCurrentUserData()
                            self.collectionsViewModel.getSubscribedCoursesByID(coursesIDs: authViewModel.userData?.subscriptions ?? [])
                        }
                        .onAppear{
                            pageTitle = activeView.rawValue
                        }
                }
            }
            
            // Bottom bar in case device is an iPhone
            if device == .iphone {
                VStack {
                    Rectangle().fill(Color.accentColor.opacity(0.8)).frame(height: 1)
                        .ignoresSafeArea()
                    HStack (alignment: .bottom) {
                        Spacer()
                        Button {
                            activeView = .home
                        } label: {
                            VStack {
                                Image(systemName: viewIcons[.home]!)
                                Text("Home")
                                    .font(.caption)

                            }
                            .disabled(activeView != .home)
                        }
                        Spacer()
                        Button {
                            activeView = .subscriptions
                        } label: {
                            VStack {
                                Image(systemName: viewIcons[.subscriptions]!)
                                Text("Subscriptions")
                                    .font(.caption)

                            }
                            .disabled(activeView != .subscriptions)
                        }
                        Spacer()
                        Button {
                            activeView = .search
                        } label: {
                            VStack {
                                Image(systemName: viewIcons[.search]!)
                                Text("Search")
                                    .font(.caption)

                            }
                            .disabled(activeView != .search)
                        }
                        if authViewModel.userData?.isEditor ?? false {
                            Spacer()
                            Button {
                                activeView = .management
                            } label: {
                                VStack {
                                    Image(systemName: viewIcons[.management]!)
                                    Text("My teachings")
                                        .font(.caption)

                                }
                                .disabled(activeView != .management)
                            }
                        }
                        Spacer()
                        Button {
                            activeView = .profile
                        } label: {
                            VStack {
                                Image(systemName: viewIcons[.profile]!)
                                Text("Profile")
                                    .font(.caption)

                            }
                            .disabled(activeView != .profile)
                        }
                        Spacer()
                    }
                    .bold()
                }
                
            }
        }
        .onAppear {
            device = verticalSizeClass == .regular && horizontalSizeClass == .regular ? .ipad : .iphone
        }
        .onChange(of: horizontalSizeClass, initial: true) { _, _ in
            device = verticalSizeClass == .regular && horizontalSizeClass == .regular ? .ipad : .iphone
        }
    }
}

#Preview {
    MainView(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel())
}
