//
//  AppUsersViewModel.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 12/10/23.
//

import Foundation
import SwiftUI

final class UserViewModel: ObservableObject {
    
    @Published var user: User = User(id: "", email: "", subscriptions: [""])
    @Published var subscriptionList: [String] = []
    @Published var error: String?
    
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository = UserRepository()){
        self.userRepository = userRepository
    }
    
    func getUserByID(userID: String) {
        userRepository.getUserByID(userID: userID) { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
                self?.subscriptionList.removeAll()
                for id in user.subscriptions {
                    self?.subscriptionList.append(id)
                }
            case .failure(let error):
                self?.error = error.localizedDescription
            }
        }
    }
}
