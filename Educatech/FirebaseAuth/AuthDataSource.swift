//
//  AuthDataSource.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import Foundation
import FirebaseAuth


final class AuthDataSource {
    
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
