//
//  UserModel.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import Foundation
import FirebaseAuth

struct UserAuthModel: Decodable, Identifiable {
    var id: String
    var email: String
}

struct UserAppModel: Decodable, Identifiable {
    var id: String
    var email: String
    var nickname: String
    var subscriptions: [String] = []
}
