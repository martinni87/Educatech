//
//  CourseModel.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 21/9/23.
//

import Foundation
import FirebaseFirestoreSwift


struct CourseModel: Decodable, Identifiable, Hashable {
    @DocumentID var id: String?
    let title: String
    let description: String
    let imageURL: String //The route in which is stored
    let creatorID: String //Id of authenticated user that creates the course
    var teacher: String
    var category: String = ""
    var numberOfStudents: Int = 0
    var rateStars: Double = 0.00
    var numberOfValorations: Int = 0
//    var price: Double = 0.00
}
