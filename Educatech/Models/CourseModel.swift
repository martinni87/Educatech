//
//  CourseModel.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 21/9/23.
//

import Foundation
import FirebaseFirestoreSwift

struct CourseModel: Decodable, Identifiable {
    @DocumentID var id: String?
    var creatorID: String //Id of authenticated user that creates the course
    var teacher: String
    var title: String
    var description: String
    var imageURL: String //The route in which is stored
    var category: String = ""
    var videosURL: [String] = []
    var numberOfStudents: Int = 0
    var rateStars: Double = 0.00
    var numberOfValorations: Int = 0
}
