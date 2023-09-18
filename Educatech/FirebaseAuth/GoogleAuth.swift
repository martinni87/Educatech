//
//  GoogleAuth.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 18/9/23.
//

import Foundation
import Firebase
import GoogleSignIn

final class GoogleAuth {
    
    func googleLogin(completionBlock: @escaping (Result<GIDGoogleUser, Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            fatalError("No client ID found in Firebase configuration")
        }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
            print("There is no root view controller")
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { signInResult, error in
            if let error = error {
                completionBlock(.failure(error))
                return
            }
            if let googleUser = signInResult?.user {
                completionBlock(.success(googleUser))
            }
        }
    }
}
