//
//  UserModel.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift

/// A model representing user authentication information.
struct UserAuthModel: Decodable, Identifiable {
    var id: String /// - id: The unique identifier of the user.
    var email: String /// - email: The email associated with the user.

}

/// A model representing additional user data.
struct UserDataModel: Decodable, Identifiable {
    @DocumentID var id: String? /// - id: The optional identifier used by Firestore.
    var email: String /// -email: The email associated with the user.
    var username: String /// - username: The username chosen by the user.
    var isEditor: Bool = false /// - isEditor: A flag indicating whether the user has editor privileges.
    var categories: [String] = [] /// - categories: An array of categories associated with the user.
    var contentCreated: [String] = [] /// - contentCreated: An array of content created by the user.
    var subscriptions: [String] = [] /// - subscriptions: An array of subscriptions the user has.
}
