//
//  AuthDataSource.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift


final class AuthDataSource {
    
    private let facebookAuth = FacebookAuth()
    private let googleAuth = GoogleAuth()
    
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
    
    func googleLogin(completionBlock: @escaping (Result<User, Error>) -> Void) {
        googleAuth.googleLogin { result in
            switch result {
            case .success(let googleUser):
                let idToken = googleUser.idToken?.tokenString ?? "No token"
                let accessToken = googleUser.accessToken.tokenString
                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
                Auth.auth().signIn(with: credential) { authDataResult, error in
                    if let error = error {
                        completionBlock(.failure(error))
                        return
                    }
                    let email = authDataResult?.user.email ?? "No email"
                    completionBlock(.success(User(email: email)))
                }
            case .failure(let failure):
                completionBlock(.failure(failure))
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
    
    func currentProvider() -> [LinkedAccounts] {
        guard let currentUser = Auth.auth().currentUser else {
            return []
        }
        //Map provider data to build a LinkAccounts array with current providers registered in Firebase
        let linkedAccounts = currentUser.providerData.map { userInfo in
            LinkedAccounts(rawValue: userInfo.providerID)
        }.compactMap { $0 } //Delete all nil values in array.
        return linkedAccounts
    }
    
    func getLastProviderCredential() -> AuthCredential? {
        guard let providerId = currentProvider().last else {
            return nil
        }
        switch providerId {
        case .facebook:
            guard let accessToken = facebookAuth.getAccessToken() else {
                return nil
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
            return credential
        case .google:
            guard let currentUser = googleAuth.getCurrentUser() else {
                return nil
            }
            let idToken = currentUser.idToken?.tokenString ?? "No id token"
            let accessToken = currentUser.accessToken.tokenString
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            return credential
        case .emailAndPassword, .apple, .unknown:
            return nil
        }
    }
    
    func linkEmailAndPassword(email: String, password: String, completionBlock: @escaping (Bool) -> Void) {
        guard let credential = getLastProviderCredential() else {
            print("No credential")
            completionBlock(false)
            return
        }
        
        Auth.auth().currentUser?.reauthenticate(with: credential, completion: { authDataResult, error in
            if let error = error {
                print("Error reauthenticating user: \(error.localizedDescription)")
                completionBlock(false)
                return
            }
            let emailAndPassword = EmailAuthProvider.credential(withEmail: email, password: password)
            Auth.auth().currentUser?.link(with: emailAndPassword, completion: { authDataResult, error in
                if let error = error {
                    print(error.localizedDescription)
                    completionBlock(false)
                    return
                }
                let email = authDataResult?.user.email ?? "No email"
                print(email)
                completionBlock(true)
            })
        })
        
    }
    
    func linkFacebook(completionBlock: @escaping (Bool) -> Void) {
        facebookAuth.facebookLogin { result in
            switch result {
            case .success(let accessToken):
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
                Auth.auth().currentUser?.link(with: credential) { authDataResult, error in
                    if let error = error {
                        print(error.localizedDescription)
                        completionBlock(false)
                        return
                    }
                    let email = authDataResult?.user.email ?? "No email"
                    print(email)
                    completionBlock(true)
                }
            case .failure(let error):
                print("Error linking user with Facebook. Error: \(error.localizedDescription)")
                completionBlock(false)
            }
        }
    }
    
    func linkGoogle(completionBlock: @escaping (Bool) -> Void) {
        googleAuth.googleLogin { result in
            switch result {
            case .success(let googleUser):
                let idToken = googleUser.idToken?.tokenString ?? "No token"
                let accessToken = googleUser.accessToken.tokenString
                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
                Auth.auth().currentUser?.link(with: credential) { authDataResult, error in
                    if let error = error {
                        print(error.localizedDescription)
                        completionBlock(false)
                        return
                    }
                    let email = authDataResult?.user.email ?? "No email"
                    print(email)
                    completionBlock(true)
                }
            case .failure(let error):
                print("Error linking user with Google. Error: \(error.localizedDescription)")
                completionBlock(false)
            }
        }
    }
}
