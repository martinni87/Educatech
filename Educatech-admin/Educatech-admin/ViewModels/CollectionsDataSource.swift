//
//  CollectionsDataSource.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 21/9/23.
//

import SwiftUI
import PhotosUI
import FirebaseFirestore
import FirebaseFirestoreSwift

final class CollectionsDataSource {
    
    private let database = Firestore.firestore()
    private let coursesCollection = "courses"
    private let usersCollection = "users"
    
    func getAllUsers(completionBlock: @escaping (Result<[UserDataModel], Error>) -> Void ){
        self.database.collection(self.usersCollection)
            .addSnapshotListener { query, error in
                if let error = error {
                    completionBlock(.failure(error)) // To return Error case
                    return
                }
                guard let documents = query?.documents.compactMap({ $0 }) else {
                    completionBlock(.success([])) // To return [UserDataModel] array empty
                    return
                }
                let users = documents.map { try? $0.data(as: UserDataModel.self) }
                    .compactMap { $0 } // To avoid nil values.
                completionBlock(.success(users)) // To return [UserDataModel] array with data
            }
    }
    
    func getAllCourses(completionBlock: @escaping (Result<[CourseModel], Error>) -> Void ){
        self.database.collection(self.coursesCollection)
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
    
    func editCourseData(changeTo course: CourseModel, completionBlock: @escaping (Result<CourseModel, Error>) -> Void) {
        let courseDocument = self.database.collection(self.coursesCollection).document(course.id ?? "0")
        courseDocument.setData(["id": course.id ?? "0",
                                "creatorID": course.creatorID,
                                "teacher": course.teacher,
                                "title": course.title,
                                "description": course.description,
                                "imageURL": course.imageURL,
                                "category": course.category,
                                "videosURL": course.videosURL,
                                "numberOfStudents": course.numberOfStudents,
                                "approved": course.approved
                               ]) { error in
            if let error = error {
                completionBlock(.failure(error))
                return
            }
            completionBlock(.success(CourseModel(id: course.id,
                                                 creatorID: course.creatorID,
                                                 teacher: course.teacher,
                                                 title: course.title,
                                                 description: course.description,
                                                 imageURL: course.imageURL,
                                                 category: course.category,
                                                 videosURL: course.videosURL,
                                                 numberOfStudents: course.numberOfStudents,
                                                 approved: course.approved)))
        }
    }
    
    func editUserData(changeTo user: UserDataModel, completionBlock: @escaping (Result<UserDataModel, Error>) -> Void) {
        let userDocument = self.database.collection(self.usersCollection).document(user.id ?? "0")
        
        userDocument.setData(["id": user.id ?? "0",
                              "email": user.email,
                              "username": user.username,
                              "isEditor": user.isEditor,
                              "categories": user.categories,
                              "contentCreated": user.contentCreated,
                              "subscriptions": user.subscriptions,
                             ]) { error in
            if let error = error {
                completionBlock(.failure(error))
                return
            }
            completionBlock(.success(UserDataModel(id: user.id,
                                                   email: user.email,
                                                   username: user.username,
                                                   isEditor: user.isEditor,
                                                   categories: user.categories,
                                                   contentCreated: user.contentCreated,
                                                   subscriptions: user.subscriptions)))
        }
    }
    
    
    // MARK: Private methods
    private func getCountOfDocuments(completionBlock: @escaping (Int) -> Void) {
        let collectionRef = self.database.collection(self.coursesCollection)
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
