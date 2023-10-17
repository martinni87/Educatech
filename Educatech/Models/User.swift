//
//  User.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import Foundation
import FirebaseAuth

struct User: Decodable, Identifiable {
    var id: String
    let email: String
    var subscriptions: [String] = []
}
