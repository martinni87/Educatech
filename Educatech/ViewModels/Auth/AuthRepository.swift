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
    
    //MARK: Registration form validations
    func emailValidations(_ formInputs: RegistrationFormInputs, completionBlock: @escaping (Bool, String?) -> Void) {
        authDataSource.emailValidations(formInputs, completionBlock: completionBlock)
    }
    
    func usernameValidations(_ formInputs: RegistrationFormInputs, completionBlock: @escaping (Bool, String?) -> Void) {
        authDataSource.usernameValidations(formInputs, completionBlock: completionBlock)
    }
    
    func passwordValidations(_ formInputs: RegistrationFormInputs, completionBlock: @escaping (Bool, String?) -> Void ) {
        authDataSource.passwordValidations(formInputs, completionBlock: completionBlock)
    }
    
    func repeatedPasswordValidations(_ formInputs: RegistrationFormInputs, completionBlock: @escaping (Bool, String?) -> Void ) {
        authDataSource.repeatedPasswordValidations(formInputs, completionBlock: completionBlock)
    }
    
    //MARK: Sign up, Login and Sign out methods
    func signUpEmail(formInputs: RegistrationFormInputs, completionBlock: @escaping (Result<UserDataModel,Error>) -> Void ) {
        authDataSource.signUpEmail(formInputs: formInputs, completionBlock: completionBlock)
    }
    
    func signInEmail(email: String, password: String, completionBlock: @escaping (Result<UserAuthModel,Error>) -> Void ) {
        authDataSource.signInEmail(email: email, password: password, completionBlock: completionBlock)
    }
    
    func signOut() throws {
        try authDataSource.signOut()
    }
    
    func getCurrentUser() -> UserAuthModel? {
        authDataSource.getCurrentUser()
    }
}

//
//    private let authDataSource: AuthDataSource
//
//    init(authDataSource: AuthDataSource = AuthDataSource()) {
//        self.authDataSource = authDataSource
//    }
//
//    func signUpEmail(email: String, password: String, completionBlock: @escaping (Result<UserAuthModel,Error>) -> Void ) {
//        authDataSource.signUpEmail(email: email, password: password, completionBlock: completionBlock)
//    }
//
//    func signInEmail(email: String, password: String, completionBlock: @escaping (Result<UserAuthModel,Error>) -> Void ) {
//        authDataSource.signInEmail(email: email, password: password, completionBlock: completionBlock)
//    }
//
//    func facebookLogin(completionBlock: @escaping (Result<UserAuthModel, Error>) -> Void ) {
//        authDataSource.facebookLogin(completionBlock: completionBlock)
//    }
//
//    func googleLogin(completionBlock: @escaping (Result<UserAuthModel, Error>) -> Void) {
//        authDataSource.googleLogin(completionBlock: completionBlock)
//    }
//
//    func getCurrentUser() -> UserAuthModel? {
//        authDataSource.getCurrentUser()
//    }
//
//    func signOut() throws {
//        try authDataSource.signOut()
//    }
//
//    func getCurrentProvider() -> [LinkedAccounts] {
//        authDataSource.currentProvider()
//    }
//
//    func linkEmailAndPassword(email: String, password: String, completionBlock: @escaping (Bool) -> Void) {
//        authDataSource.linkEmailAndPassword(email: email, password: password, completionBlock: completionBlock)
//    }
//
//    func linkFacebook(completionBlock: @escaping (Bool) -> Void) {
//        authDataSource.linkFacebook(completionBlock: completionBlock)
//    }
//
//    func linkGoogle(completionBlock: @escaping (Bool) -> Void) {
//        authDataSource.linkGoogle(completionBlock: completionBlock)
//    }
//}
