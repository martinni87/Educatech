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
    
    func cleanCache() {
        self.userAuth = nil
        self.userData = nil
        
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
    
    func signUpEmail(formInputs: RegistrationFormInputs) {
        //First clean all error records
        self.cleanCache()
        
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
        self.cleanCache()

        //Next, if email and password are correct, try login
        authRepository.signInEmail(formInputs: formInputs) { [weak self] result in
            switch result {
            case .success(let userData):
                self?.userAuth = UserAuthModel(id: userData.id!, email: userData.email)
                self?.userData = userData
            case .failure(let error):
                self?.allowContinue = true
                self?.requestErrorMsg = error.localizedDescription
            }
        }
    }
    
    func signOut() {
        //Begin or reset error to nil to avoid repetitive error messages
        self.requestErrorMsg = nil
        
        do {
            try authRepository.signOut()
            self.cleanCache()
        }
        catch {
            self.requestErrorMsg = "Error attepting sign out. Please contact the admin."
        }
    }
    
    func getCurrentUserAuth() {
        self.userAuth = authRepository.getCurrentUserAuth()
    }
    
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
}
    
//    @Published var user: UserAuthModel?
//    @Published var error: String?
//    @Published var linkedAccounts: [LinkedAccounts] = []
//    @Published var showAlert: Bool = false
//    @Published var didLinkedAccount: Bool = false
//    
//    private let authRepository: AuthRepository
//    
//    init(authRepository: AuthRepository = AuthRepository()) {
//        self.authRepository = authRepository
//        self.getCurrentUser()
//    }
//    
//    func signUpEmail(email: String, nickname: String, password: String, repeatPassword: String, userViewModel: UserViewModel) {
//        //Begin or reset error to nil to avoid repetitive error messages
//        self.error = nil
//        
//        //First check if email and password are well formatted
//        guard self.authValidations(email, nickname, password, repeatPassword) else {
//            return
//        }
//        
//        //Check nickname availability
////        userViewModel.check
//        
//        //Next, if email and password are correct, try register in Database
//        authRepository.signUpEmail(email: email, password: password) { [weak self] result in
//            switch result {
//            case .success(let user):
//                self?.user = user
//                userViewModel.createNewUser(id: user.id, email: user.email, nickname: nickname)
//            case .failure(let error):
//                self?.showAlert = true
//                self?.error = error.localizedDescription
//            }
//        }
//    }
//    
//    func signInEmail(email: String, password: String) {
//        //Begin or reset error to nil to avoid repetitive error messages
//        self.error = nil
//        
//        //Next, if email and password are correct, try login
//        authRepository.signInEmail(email: email, password: password) { [weak self] result in
//            switch result {
//            case .success(let user):
//                self?.user = user
//            case .failure(let error):
//                self?.showAlert = true
//                self?.error = error.localizedDescription
//            }
//        }
//    }
//    
//    func facebookLogin(userViewModel: UserViewModel) {
//        //Begin or reset error to nil to avoid repetitive error messages
//        self.error = nil
//        
//        authRepository.facebookLogin { [weak self] result in
//            switch result {
//            case .success(let user):
//                self?.user = user
////                userViewModel.createNewUser(id: user.id, email: user.email)
//            case .failure(let error):
//                self?.error = error.localizedDescription
//            }
//        }
//    }
//    
//    func googleLogin(userViewModel: UserViewModel) {
//        //Begin or reset error to nil to avoid repetitive error messages
//        self.error = nil
//        
//        authRepository.googleLogin { [weak self] result in
//            switch result {
//            case .success(let user):
//                self?.user = user
////                userViewModel.createNewUser(id: user.id, email: user.email)
//            case .failure(let error):
//                self?.error = error.localizedDescription
//            }
//        }
//    }
//    
//    func appleLogin() {
//        print("Apple login. Coming soon ...")
//    }
//    
//    func getCurrentUser() {
//        self.user = authRepository.getCurrentUser()
//    }
//    
//    func signOut() {
//        //Begin or reset error to nil to avoid repetitive error messages
//        self.error = nil
//        
//        do {
//            try authRepository.signOut()
//            self.user = nil
//            self.error = nil
//            self.linkedAccounts = []
//            self.showAlert = false
//            self.didLinkedAccount = false
//        }
//        catch {
//            self.error = "Error attepting sign out. Please contact the admin."
//        }
//    }
//    
//    func getCurrentProvider() {
//        self.linkedAccounts = authRepository.getCurrentProvider()
//    }
//    
//    func isEmailAndPasswordLinked() -> Bool {
//        self.linkedAccounts.contains(where: { $0.rawValue == "password" })
//    }
//    
//    func isFacebookLinked() -> Bool {
//        self.linkedAccounts.contains(where: { $0.rawValue == "facebook.com" })
//    }
//    
//    func isGoogleLinked() -> Bool {
//        self.linkedAccounts.contains(where: { $0.rawValue == "google.com" })
//    }
//    
//    func isAppleLinked() -> Bool {
//        self.linkedAccounts.contains(where: { $0.rawValue == "apple.com" })
//    }
//    
//    func linkEmailAndPassword(email: String, password: String) {
//        authRepository.linkEmailAndPassword(email: email, password: password) { [weak self] linkResult in
//            self?.didLinkedAccount = linkResult
//            self?.showAlert.toggle()
//            self?.getCurrentProvider()
//        }
//    }
//    
//    func linkFacebook() {
//        authRepository.linkFacebook { [weak self] linkResult in
//            self?.didLinkedAccount = linkResult
//            self?.showAlert.toggle()
//            self?.getCurrentProvider()
//        }
//    }
//    
//    func linkGoogle() {
//        authRepository.linkGoogle { [weak self] linkResult in
//            self?.didLinkedAccount = linkResult
//            self?.showAlert.toggle()
//            self?.getCurrentProvider()
//        }
//    }
//    
//    
//    // MARK: Private functinos for the View Model
//    private func authValidations(_ email: String, _ name: String, _ password: String, _ repeatPassword: String) -> Bool {
//        guard email.validateNotEmptyString().isValid else {
//            self.error = email.validateNotEmptyString().errorMsg
//            return false
//        }
//        guard email.validateEmail().isValid else {
//            self.error = email.validateEmail().errorMsg
//            return false
//        }
//        guard name.validateNotEmptyString().isValid else {
//            self.error = name.validateNotEmptyString().errorMsg
//            return false
//        }
//        guard password.validateNotEmptyString().isValid else {
//            self.error = password.validateNotEmptyString().errorMsg
//            return false
//        }
//        guard repeatPassword.validateNotEmptyString().isValid else {
//            self.error = repeatPassword.validateNotEmptyString().errorMsg
//            return false
//        }
//        guard password.validatePassword(for: email, repeated: repeatPassword).isValid else {
//            self.error = password.validatePassword(for: email, repeated: repeatPassword).errorMsg
//            return false
//        }
//        return true
//    }
//}
