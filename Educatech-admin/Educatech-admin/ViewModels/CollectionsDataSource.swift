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
    
    func getCourseByID(courseID: String, completionBlock: @escaping (Result<CourseModel, Error>) -> Void) {
        let document = self.database.collection(self.coursesCollection).document(courseID)
        document.getDocument(source: .server) { document, error in
            if let error = error {
                completionBlock(.failure(error))
                return
            }
            if let document = document, document.exists {
                let id = document.get("id") as! String
                let creatorID = document.get("creatorID") as! String
                let teacher = document.get("teacher") as! String
                let title = document.get("title") as! String
                let description = document.get("description") as! String
                let imageURL = document.get("imageURL") as! String
                let category = document.get("category") as! String
                let videosURL = document.get("videosURL") as! [String]
                let numberOfStudents = document.get("numberOfStudents") as! Int
                let approved = document.get("approved") as! Bool
                completionBlock(.success(CourseModel(id: id,
                                                     creatorID: creatorID,
                                                     teacher: teacher,
                                                     title: title,
                                                     description: description,
                                                     imageURL: imageURL,
                                                     category: category,
                                                     videosURL: videosURL,
                                                     numberOfStudents: numberOfStudents,
                                                     approved: approved)))
                return
            }
        }
    }
    
    func getCoursesByCreatorID(creatorID: String, completionBlock: @escaping (Result<[CourseModel], Error>) -> Void ){
        self.database.collection(self.coursesCollection).whereField("creatorID", isEqualTo: creatorID)
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
    
    func getCoursesByCategory(category: String, completionBlock: @escaping(Result<[CourseModel], Error>) -> Void) {
        self.database.collection(self.coursesCollection).whereField("category", isEqualTo: category)
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
    
    func addNewManagedCourseToUser(newCourse: CourseModel, userData: UserDataModel, completionBlock: @escaping (Result<CourseModel, Error>) -> Void ) {
        //Getting document for current user
        let document = self.database.collection(self.usersCollection).document(userData.id ?? "0")
        var contentCreated = userData.contentCreated
        contentCreated.append(newCourse.id ?? "0")
        //Setting new data
        document.setData( ["id": userData.id ?? "0",
                           "email": userData.email,
                           "username": userData.username,
                           "isEditor": userData.isEditor,
                           "categories": userData.categories,
                           "contentCreated": contentCreated,
                           "subscriptions": userData.subscriptions
                          ]) { error in
            if let error = error {
                completionBlock(.failure(error))
                return
            }
            completionBlock(.success(newCourse))
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
