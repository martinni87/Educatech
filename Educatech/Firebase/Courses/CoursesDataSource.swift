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
    
    func getCoursesByCreatorID(creatorID: String, completionBlock: @escaping (Result<[CourseModel], Error>) -> Void ){
        self.database.collection(self.collection).whereField("creatorID", isEqualTo: creatorID)
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
    
    func createNewCourse(title: String, description: String, imageURL: String, creatorID: String, completionBlock: @escaping (Result<CourseModel, Error>) -> Void ) {
        self.getCountOfDocuments { count in
            //Get number of documents to create bew document with custom ID
            let id: String = "000\(count)_\(title.lowercased().replacingOccurrences(of: " ", with: "_"))"
            let newDocument = self.database.collection(self.collection).document(id)
            
            //Setting new document with the data given by the user
            newDocument.setData( ["title": title, "description": description, "image": imageURL, "creatorID": creatorID]) { error in
                if let error = error {
                    completionBlock(.failure(error))
                    return
                }
                let course = CourseModel(title: title, description: description, image: imageURL, creatorID: creatorID)
                completionBlock(.success(course))
            }
        }
    }
    
    func updateCourseData(creatorID: String, courseID: String, title: String, description: String, imageURL: String, completionBlock: @escaping (Error) -> Void ) {
        let currentDocument = self.database.collection(self.collection).document(courseID)
        //Setting new document with the data given by the user
        currentDocument.setData( ["title": title, "description": description, "image": imageURL, "creatorID": creatorID] ) { error in
            if let error = error {
                completionBlock(error)
                return
            }
        }
    }
    
    // MARK: Private methods
    private func getCountOfDocuments(completionBlock: @escaping (Int) -> Void) {
        let collectionRef = self.database.collection(self.collection)
        collectionRef.getDocuments { query, error in
            if let error = error {
                print("Error counting number of documents. \(error)")
                return
            }
            let numberOfDocuments = query?.documents.count ?? 0
            completionBlock(numberOfDocuments)
        }
    }
}
