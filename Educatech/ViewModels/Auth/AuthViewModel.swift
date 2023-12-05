//
//  AuthViewModel.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import Foundation

final class AuthViewModel: ObservableObject {
    @Published var userAuth: UserAuthModel?
    @Published var userData: UserDataModel?
    
    @Published var requestErrorMsg: String?
    @Published var emailErrorMsg: String?
    @Published var usernameErrorMsg: String?
    @Published var passwordErrorMsg: String?
    @Published var repeatPasswordErrorMsg: String?
    
    @Published var hasRequestError: Bool = false
    @Published var allowContinue: Bool = false
    
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository = AuthRepository()) {
        self.authRepository = authRepository
        self.getCurrentUserAuth()
        self.getCurrentUserData()
    }
    
    func cleanAll() {
        self.userAuth = nil
        self.userData = nil
        self.cleanErrors()
    }
    
    func cleanErrors() {
        self.requestErrorMsg = nil
        self.emailErrorMsg = nil
        self.usernameErrorMsg = nil
        self.passwordErrorMsg = nil
        self.repeatPasswordErrorMsg = nil
        
        self.hasRequestError = false
        self.allowContinue = false
    }
    
    //MARK: Registration form validations
    func registrationFormValidations(_ formInputs: RegistrationFormInputs) {
        //Check email
        self.authRepository.emailValidations(formInputs) { [weak self] isValid, errorMsg in
            if !isValid {
                self?.emailErrorMsg = errorMsg
                return
            }
            self?.emailErrorMsg = nil
            //Check username
            self!.authRepository.usernameValidations(formInputs) { [weak self] isValid, errorMsg in
                if !isValid {
                    self?.usernameErrorMsg = errorMsg
                    return
                }
                self?.usernameErrorMsg = nil
                //Check password
                self!.authRepository.passwordValidations(formInputs) { [weak self] isValid, errorMsg in
                    if !isValid {
                        self?.passwordErrorMsg = errorMsg
                        return
                    }
                    self?.passwordErrorMsg = nil
                    //Check repeatedPassword
                    self!.authRepository.repeatedPasswordValidations(formInputs) { isValid, errorMsg in
                        if !isValid {
                            self?.passwordErrorMsg = errorMsg
                            self?.repeatPasswordErrorMsg = errorMsg
                            return
                        }
                        self?.repeatPasswordErrorMsg = nil
                        self?.allowContinue = true
                    }
                }
            }
        }
    }
    
    //MARK: Sign up, sign in, logout and auth methods
    
    func signUpEmail(formInputs: RegistrationFormInputs) {
        //First clean all error records
        self.cleanAll()
        
        //Then, if validations passed, then attemp create new user
        authRepository.signUpEmail(formInputs: formInputs) { [weak self] result in
            switch result {
            case .success(let userData):
                self?.userAuth = UserAuthModel(id: userData.id!, email: userData.email)
                self?.userData = userData
            case .failure(let requestErrorMsg):
                self?.requestErrorMsg = requestErrorMsg.localizedDescription
                self?.hasRequestError = true
            }
        }
    }
    
    func signInEmail(formInputs: LoginFormInputs) {
        //Begin or reset error to nil to avoid repetitive error messages
        self.cleanAll()

        //Next, if email and password are correct, try login
        authRepository.signInEmail(formInputs: formInputs) { [weak self] result in
            switch result {
            case .success(let userData):
                self?.userAuth = UserAuthModel(id: userData.id!, email: userData.email)
                self?.userData = userData
            case .failure(let error):
                self?.hasRequestError = true
                self?.requestErrorMsg = error.localizedDescription
            }
        }
    }
    
    func signOut() {
        //Begin or reset error to nil to avoid repetitive error messages
        self.requestErrorMsg = nil
        
        do {
            try authRepository.signOut()
            self.cleanAll()
        }
        catch {
            self.requestErrorMsg = "Error attepting sign out. Please contact the admin."
        }
    }
    
    func getCurrentUserAuth() {
        self.userAuth = authRepository.getCurrentUserAuth()
    }
    
    //MARK: User Data
    
    func getCurrentUserData() {
        authRepository.getCurrentUserData { [weak self] result in
            switch result {
            case .success(let user):
                self?.userData = user
            case .failure(let requestErrorMsg):
                self?.requestErrorMsg = requestErrorMsg.localizedDescription
                self?.hasRequestError = true
            }
        }
    }
    
    func editUserData(changeTo userData: UserDataModel) {
        self.cleanErrors()
        authRepository.editUserData(changeTo: userData) { [weak self] result in
            switch result {
            case .success(let newUserData):
                self?.userData = newUserData
            case .failure(let requestErrorMsg):
                self?.requestErrorMsg = requestErrorMsg.localizedDescription
                self?.hasRequestError = true
            }
        }
    }
}
