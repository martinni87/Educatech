//
//  UserModel.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift

struct UserAuthModel: Decodable, Identifiable {
    var id: String
    var email: String
}

struct UserDataModel: Decodable, Identifiable {
    @DocumentID var id: String?
    var email: String
    var username: String
    var isEditor: Bool = false
    var categories: [String] = []
//    var categories: Set<String> = []
    var contentCreated: [String] = []
    var subscriptions: [String] = []
}
