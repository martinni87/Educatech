//
//  CourseModel.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 21/9/23.
//

import Foundation
import FirebaseFirestoreSwift

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

let EXAMPLE_COURSE = CourseModel(id: "0", creatorID: "0", teacher: "Teacher", title: "Title", description: "Description", imageURL: "https://images.unsplash.com/photo-1590479773265-7464e5d48118?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",category: "Swift", videosURL: ["Video1", "Video2", "Video3"])
