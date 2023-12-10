//
//  CourseModel.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 21/9/23.
//

import Foundation
import FirebaseFirestoreSwift

/**
 A model representing a course, including information about the course creator, title, description,
 category, videos, and other relevant details.
 
 - Important: The `id` property is an optional identifier used by Firestore.
 */
struct CourseModel: Decodable, Identifiable, Equatable, Hashable {
    @DocumentID var id: String? /// The optional identifier used by Firestore.
    var creatorID: String = "" /// The identifier of the authenticated user who creates the course.
    var teacher: String = "" /// The teacher associated with the course.
    var title: String = "" /// The title of the course.
    var description: String = "" /// The description of the course.
    var imageURL: String = "" /// The URL where the image associated with the course is stored.
    var category: String = "" /// The category to which the course belongs.
    var videosURL: [String] = [] /// An array of URLs representing videos associated with the course.
    var numberOfStudents: Int = 0 /// The number of students enrolled in the course.
    var approved: Bool = false /// A flag indicating whether the course is approved.
}

/// An example course for demonstration purposes.
let EXAMPLE_COURSE = CourseModel(
    id: "0",
    creatorID: "0",
    teacher: "Teacher",
    title: "Title",
    description: "Description",
    imageURL: "https://images.unsplash.com/photo-1590479773265-7464e5d48118?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    category: "Swift",
    videosURL: ["Video1", "Video2", "Video3"]
)
