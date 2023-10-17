//
//  UserRepository.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 12/10/23.
//

import Foundation

final class UserRepository {
    
    private let userDataSource: UserDataSource
    
    init(userDataSource: UserDataSource = UserDataSource()) {
        self.userDataSource = userDataSource
    }
    
    func getUserByID(userID: String, completionBlock: @escaping (Result<User, Error>) -> Void ) {
        userDataSource.getUserByID(userID: userID, completionBlock: completionBlock)
    }
    
}
