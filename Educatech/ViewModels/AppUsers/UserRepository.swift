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
    
//    func getUserByID(userID: String, completionBlock: @escaping (Result<UserAppModel, Error>) -> Void ) {
//        userDataSource.getUserByID(userID: userID, completionBlock: completionBlock)
//    }
    
    func createNewUser(id: String, email: String, nickname: String, completionBlock: @escaping (Result<UserAppModel, Error>) -> Void ) {
        userDataSource.createNewUser(id: id, email: email, nickname: nickname, completionBlock: completionBlock)
    }
}
