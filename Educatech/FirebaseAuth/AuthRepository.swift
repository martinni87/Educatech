//
//  AuthRepository.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import Foundation

final class AuthRepository {
    
    private let authDataSource: AuthDataSource
    
    init(authDataSource: AuthDataSource = AuthDataSource()) {
        self.authDataSource = authDataSource
    }
    
    func signUpEmail(email: String, password: String, completionBlock: @escaping (Result<User,Error>) -> Void ) {
        authDataSource.signUpEmail(email: email, password: password, completionBlock: completionBlock)
    }
    
    func signInEmail(email: String, password: String, completionBlock: @escaping (Result<User,Error>) -> Void ) {
        authDataSource.signInEmail(email: email, password: password, completionBlock: completionBlock)
    }
    
    func facebookLogin(completionBlock: @escaping (Result<User, Error>) -> Void ) {
        authDataSource.facebookLogin(completionBlock: completionBlock)
    }
    
    func getCurrentUser() -> User? {
        authDataSource.getCurrentUser()
    }
    
    func signOut() throws {
        try authDataSource.signOut()
    }
}
