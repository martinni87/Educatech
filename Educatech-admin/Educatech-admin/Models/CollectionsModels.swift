//
//  UserModel.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift

struct UserDataModel: Decodable, Identifiable {
    @DocumentID var id: String?
    var email: String = ""
    var username: String = ""
    var isEditor: Bool = false
    var categories: [String] = []
    var contentCreated: [String] = []
    var subscriptions: [String] = []
}

struct CourseModel: Decodable, Identifiable, Equatable, Hashable {
    @DocumentID var id: String?
    var creatorID: String = "" //Id of authenticated user that creates the course
    var teacher: String = ""
    var title: String = ""
    var description: String = ""
    var imageURL: String = "" //The route in which is stored
    var category: String = ""
    var videosURL: [String] = []
    var numberOfStudents: Int = 0
    var approved: Bool = false
}
