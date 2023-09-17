//
//  FacebookAuth.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 17/9/23.
//

import Foundation
import FacebookLogin

final class FacebookAuth {
    
    private let loginManager = LoginManager()
    
    func facebookLogin(completionBlock: @escaping (Result<String, Error>) -> Void ) {
        loginManager.logIn(
            permissions: ["email"],
            from: nil) { loginResult, error in
                if let error = error {
                    completionBlock(.failure(error))
                    return
                }
                let token = loginResult?.token?.tokenString
                completionBlock(.success(token ?? "Empty token"))
            }
    }
}
