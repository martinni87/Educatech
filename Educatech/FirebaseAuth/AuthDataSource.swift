//
//  AuthDataSource.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import Foundation
import FirebaseAuth
import Firebase
import GoogleSignIn
import UIKit



final class AuthDataSource {
    
    let facebookAuth = FacebookAuth()
    
    func signUpEmail(email: String, password: String, completionBlock: @escaping (Result<User,Error>) -> Void ) {
        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            if let error = error {
                completionBlock(.failure(error))
                return
            }
            let email = authDataResult?.user.email ?? "No email"
            completionBlock(.success(User(email: email)))
        }
    }
    
    func signInEmail(email: String, password: String, completionBlock: @escaping (Result<User,Error>) -> Void ) {
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            if let error = error {
                completionBlock(.failure(error))
                return
            }
            let email = authDataResult?.user.email ?? "No email"
            completionBlock(.success(User(email: email)))
        }
    }
    
    func facebookLogin(completionBlock: @escaping (Result<User, Error>) -> Void ) {
        facebookAuth.facebookLogin { result in
            switch result {
            case .success(let accessToken):
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
                Auth.auth().signIn(with: credential) { authDataResult, error in
                    if let error = error {
                        completionBlock(.failure(error))
                        return
                    }
                    let email = authDataResult?.user.email ?? "No email"
                    completionBlock(.success(User(email: email)))
                }
            case .failure(let error):
                print("Error signing in with facebook at Data Source. Error: \(error.localizedDescription)")
                completionBlock(.failure(error))
            }
        }
    }
    
    func getCurrentUser() -> User? {
        if let email = Auth.auth().currentUser?.email {
            return User(email: email)
        }
        else {
            return nil
        }
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
