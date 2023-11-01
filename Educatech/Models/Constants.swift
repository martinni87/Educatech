//
//  Constants.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 17/10/23.
//

import Foundation

let KLOREMIPSUM = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
"""

let categories = [
    "Mobile Development", "Web Development", "Testing", "Data Science", "Machine Learning",
    "Python", "Swift", "Objective-C", "Java", "Kotlin", "UX/UI", "MERN Stack", "HTML", "CSS", "JavaScript"
]

let COURSE_LIST_EXAMPLE = [
    CourseModel(id: UUID().uuidString,
                title: "Example 1",
                description: KLOREMIPSUM,
                imageURL: "photo-0",
                creatorID: "8z38yBr08GTnTEXzLtEYi5r9grH3",
                teacher: "Teacher 1",
                category: categories[Int.random(in: 0..<categories.count)],
                numberOfStudents: Int.random(in: 50..<300),
                rateStars: Double.random(in: 0..<6),
                numberOfValorations: Int.random(in: 0..<50)/*,*/
                /*price: 9.99*/),
    CourseModel(id: UUID().uuidString,
                title: "Example 2",
                description: KLOREMIPSUM,
                imageURL: "photo-1",
                creatorID: "8z38yBr08GTnTEXzLtEYi5r9grH3",
                teacher: "Teacher 2",
                category: categories[Int.random(in: 0..<categories.count)],
                numberOfStudents: Int.random(in: 50..<300),
                rateStars: Double.random(in: 0..<6),
                numberOfValorations: Int.random(in: 0..<50)/*,*/
                /*price: 9.99*/),
    CourseModel(id: UUID().uuidString,
                title: "Example 3",
                description: KLOREMIPSUM,
                imageURL: "photo-2",
                creatorID: "8z38yBr08GTnTEXzLtEYi5r9grH3",
                teacher: "Teacher 1",
                category: categories[Int.random(in: 0..<categories.count)],
                numberOfStudents: Int.random(in: 50..<300),
                rateStars: Double.random(in: 0..<6),
                numberOfValorations: Int.random(in: 0..<50)/*,*/
                /*price: 9.99*/),
    CourseModel(id: UUID().uuidString,
                title: "Example 4",
                description: KLOREMIPSUM,
                imageURL: "photo-3",
                creatorID: UUID().uuidString,
                teacher: "Teacher 2",
                category: categories[Int.random(in: 0..<categories.count)],
                numberOfStudents: Int.random(in: 50..<300),
                rateStars: Double.random(in: 0..<6),
                numberOfValorations: Int.random(in: 0..<50)/*,*/
                /*price: 9.99*/),
    CourseModel(id: UUID().uuidString,
                title: "Example 5",
                description: KLOREMIPSUM,
                imageURL: "photo-4",
                creatorID: "8z38yBr08GTnTEXzLtEYi5r9grH3",
                teacher: "Teacher 3",
                category: categories[Int.random(in: 0..<categories.count)],
                numberOfStudents: Int.random(in: 50..<300),
                rateStars: Double.random(in: 0..<6),
                numberOfValorations: Int.random(in: 0..<50)/*,*/
                /*price: 9.99*/),
    CourseModel(id: UUID().uuidString,
                title: "Example 6",
                description: KLOREMIPSUM,
                imageURL: "photo-5",
                creatorID: "8z38yBr08GTnTEXzLtEYi5r9grH3",
                teacher: "Teacher 1",
                category: categories[Int.random(in: 0..<categories.count)],
                numberOfStudents: Int.random(in: 50..<300),
                rateStars: Double.random(in: 0..<6),
                numberOfValorations: Int.random(in: 0..<50)/*,*/
                /*price: 9.99*/)
]
