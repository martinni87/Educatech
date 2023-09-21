//
//  AuthViewModel.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import Foundation

final class AuthViewModel: ObservableObject {
    
    @Published var user: User?
    @Published var error: Error?
    @Published var linkedAccounts: [LinkedAccounts] = []
    @Published var showAlert: Bool = false
    @Published var didLinkedAccount: Bool = false
    
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository = AuthRepository()) {
        self.authRepository = authRepository
        self.getCurrentUser()
    }
    
    func signUpEmail(email: String, password: String) {
        authRepository.signUpEmail(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
            case .failure(let error):
                self?.error = error
            }
        }
    }
    
    func signInEmail(email: String, password: String) {
        authRepository.signInEmail(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
            case .failure(let error):
                self?.error = error
            }
        }
    }
    
    func facebookLogin() {
        authRepository.facebookLogin { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
            case .failure(let error):
                self?.error = error
            }
        }
    }
    
    func googleLogin() {
        authRepository.googleLogin { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
            case .failure(let error):
                self?.error = error
            }
        }
    }
    
    func appleLogin() {
        print("Apple login. Coming soon ...")
    }
    
    func getCurrentUser() {
        self.user = authRepository.getCurrentUser()
    }
    
    func signOut() {
        do {
            try authRepository.signOut()
            self.user = nil
        }
        catch {
            print("Error sign out")
        }
    }
    
    func getCurrentProvider() {
        self.linkedAccounts = authRepository.getCurrentProvider()
    }
    
    func isEmailAndPasswordLinked() -> Bool {
        self.linkedAccounts.contains(where: { $0.rawValue == "password" })
    }
    
    func isFacebookLinked() -> Bool {
        self.linkedAccounts.contains(where: { $0.rawValue == "facebook.com" })
    }
    
    func isGoogleLinked() -> Bool {
        self.linkedAccounts.contains(where: { $0.rawValue == "google.com" })
    }
    
    func isAppleLinked() -> Bool {
        self.linkedAccounts.contains(where: { $0.rawValue == "apple.com" })
    }
    
    func linkEmailAndPassword(email: String, password: String) {
        authRepository.linkEmailAndPassword(email: email, password: password) { [weak self] linkResult in
            self?.didLinkedAccount = linkResult
            self?.showAlert.toggle()
            self?.getCurrentProvider()
        }
    }
    
    func linkFacebook() {
        authRepository.linkFacebook { [weak self] linkResult in
            self?.didLinkedAccount = linkResult
            self?.showAlert.toggle()
            self?.getCurrentProvider()
        }
    }
    
    func linkGoogle() {
        authRepository.linkGoogle { [weak self] linkResult in
            self?.didLinkedAccount = linkResult
            self?.showAlert.toggle()
            self?.getCurrentProvider()
        }
    }
}
