//
//  CoursesDataSource.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 21/9/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class CoursesDataSource {
    
    private let database = Firestore.firestore()
    private let collection = "courses"
    
    func getAllCourses(completionBlock: @escaping (Result<[CourseModel], Error>) -> Void ){
        self.database.collection(self.collection)
            .addSnapshotListener { query, error in
                if let error = error {
                    completionBlock(.failure(error)) // To return Error case
                    return
                }
                guard let documents = query?.documents.compactMap({ $0 }) else {
                    completionBlock(.success([])) // To return [CourseModel] array empty
                    return
                }
                let courses = documents.map { try? $0.data(as: CourseModel.self) }
                    .compactMap { $0 } // To avoid nil values.
                completionBlock(.success(courses)) // To return [CourseModel] array with data
            }
    }
    
    func createNewCourse(title: String, description: String, imageURL: String, completionBlock: @escaping (Result<CourseModel, Error>) -> Void ) {
        self.database.collection(self.collection).addDocument(data: ["title": title, "description": description, "image": imageURL]) { error in
            if let error = error {
                completionBlock(.failure(error))
                return
            }
            completionBlock(.success(CourseModel(title: title, description: description, image: imageURL)))
        }
    }
}
