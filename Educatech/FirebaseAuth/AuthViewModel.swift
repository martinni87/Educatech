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
}
