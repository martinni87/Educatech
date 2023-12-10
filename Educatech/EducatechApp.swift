//
//  EducatechApp.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseAuth
import FacebookLogin
import GoogleSignIn

/**
 The `AppDelegate` class serves as the application delegate, handling lifecycle events and URL interactions.
 Conforms to the `UIApplicationDelegate` protocol.
 */
class AppDelegate: NSObject, UIApplicationDelegate {
    /**
     Called when the application has finished launching.
     
     This method configures the Facebook SDK and Firebase framework. (Not in use)
     
     - Parameters:
     - application: The singleton app object.
     - launchOptions: A dictionary indicating the reason the app was launched.
     
     - Returns: `true` if the launch was successful, otherwise `false`.
     */
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            // Configure Facebook SDK (Not in use)
            ApplicationDelegate.shared.application(application,
                                                   didFinishLaunchingWithOptions: launchOptions)
            // Configure Firebase
            FirebaseApp.configure()
            
            return true
        }
    
    /**
     Handles the opening of a URL by delegating to the Google Sign-In framework. (Not in use)
     
     - Parameters:
     - app: The app object.
     - url: The URL resource to open.
     - options: A dictionary of URL handling options.
     
     - Returns: `true` if the URL was successfully handled, otherwise `false`.
     */

    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
            return GIDSignIn.sharedInstance.handle(url)
        }
}


@main
struct EducatechApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var collectionsViewModel = CollectionsViewModel()
    
    var body: some Scene {
        WindowGroup {
            if let _ = authViewModel.userAuth?.id {
                MainView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
                    .task {
                        self.authViewModel.getCurrentUserData()
                        collectionsViewModel.getCoursesByCategories(categories: authViewModel.userData?.categories ?? [])
                        collectionsViewModel.getCoursesByCreatorID(creatorID: authViewModel.userData?.id ?? "0")
                        collectionsViewModel.getSubscribedCoursesByID(coursesIDs: authViewModel.userData?.subscriptions ?? [])
                    }
            }
            else {
                InitialView(authViewModel: authViewModel)
            }
        }
    }
}
