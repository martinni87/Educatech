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
    
    //MARK: Sign up, Login, Sign out and auth methods
    func signUpEmail(formInputs: RegistrationFormInputs, completionBlock: @escaping (Result<UserDataModel,Error>) -> Void ) {
        authDataSource.signUpEmail(formInputs: formInputs, completionBlock: completionBlock)
    }
    
    func signInEmail(formInputs: LoginFormInputs, completionBlock: @escaping (Result<UserDataModel,Error>) -> Void ) {
        authDataSource.signInEmail(formInputs: formInputs, completionBlock: completionBlock)
    }
    
    func signOut() throws {
        try authDataSource.signOut()
    }
    
    func getCurrentUserAuth() -> UserAuthModel? {
        authDataSource.getCurrentUserAuth()
    }
    
    //MARK: Users Database methods and Auth info

    func getCurrentUserData(completionBlock: @escaping (Result<UserDataModel, Error>) -> Void) {
        authDataSource.getCurrentUserData(completionBlock: completionBlock)
    }
    
    func editUserData(changeTo userData: UserDataModel, completionBlock: @escaping (Result<UserDataModel, Error>) -> Void) {
        authDataSource.editUserData(changeTo: userData, completionBlock: completionBlock)
    }

}
