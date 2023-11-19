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
                let rateStars = document.get("rateStars") as! Double
                let numberOfValorations = document.get("numberOfValorations") as! Int
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
                                                     rateStars: rateStars,
                                                     numberOfValorations: numberOfValorations,
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
    
    func createNewCourse(formInputs: CreateCourseFormInputs, userData: UserDataModel, completionBlock: @escaping (Result<CourseModel, Error>) -> Void ) {
        self.getCountOfDocuments { count in
            //Get number of documents to create bew document with custom ID
            let id: String = "\(count)_\(formInputs.title.lowercased().replacingOccurrences(of: " ", with: "_"))"
            
            //Upload picture and get new url from server
            StorageManager().uploadPicture(courseID: id, photoItem: formInputs.selectedPicture ?? PhotosPickerItem(itemIdentifier: "No picture")) { result in
                switch result {
                case .failure(let error):
                    completionBlock(.failure(error))
                    return
                case .success(let urlString):
                    let pictureURL = urlString
                    
                    //Upload videos and get url array from server
                    var count = 1
                    formInputs.selectedVideos.forEach { selectedVideo in
                        StorageManager().uploadVideo(courseID: id, selectedVideo: selectedVideo) { result in
                            switch result {
                            case .failure(let error):
                                completionBlock(.failure(error))
                                return
                            case .success(_):
                                if count == formInputs.selectedVideos.count {
                                    StorageManager().retrieveVideosList(courseID: id) { result in
                                        switch result {
                                        case .failure(let error):
                                            completionBlock(.failure(error))
                                        case .success(let urlStringList):
                                            let videosURL = urlStringList
                                            
                                            //Creating new collection with id
                                            let newDocument = self.database.collection(self.coursesCollection).document(id)
                                            
                                            //Setting new document with the data given by the user
                                            let newCourse = CourseModel(id: id,
                                                                        creatorID: formInputs.creatorID,
                                                                        teacher: formInputs.teacher,
                                                                        title: formInputs.title,
                                                                        description: formInputs.description,
                                                                        imageURL: pictureURL,
                                                                        category: formInputs.category,
                                                                        videosURL: videosURL,
                                                                        numberOfStudents: 0,
                                                                        rateStars: 0,
                                                                        numberOfValorations: 0,
                                                                        approved: false)
                                            
                                            newDocument.setData( ["id": id,
                                                                  "creatorID": newCourse.creatorID,
                                                                  "teacher": newCourse.teacher,
                                                                  "title": newCourse.title,
                                                                  "description": newCourse.description,
                                                                  "imageURL": newCourse.imageURL,
                                                                  "category": newCourse.category,
                                                                  "videosURL": newCourse.videosURL,
                                                                  "numberOfStudents": newCourse.numberOfStudents,
                                                                  "rateStars": newCourse.rateStars,
                                                                  "numberOfValorations": newCourse.numberOfValorations,
                                                                  "approved": newCourse.approved
                                                                 ]) { error in
                                                if let error = error {
                                                    completionBlock(.failure(error))
                                                    return
                                                }
                                                else{
                                                    self.addNewManagedCourseToUser(newCourse: newCourse, userData: userData) { result in
                                                        switch result {
                                                        case .success(let newCourse):
                                                            completionBlock(.success(newCourse))
                                                        case .failure(let error):
                                                            completionBlock(.failure(error))
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                count += 1
                            }
                        }
                    }
                }
            }
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



//
//    func getSubscribedCoursesByIDList(coursesID: [String], completionBlock: @escaping (Result<[CourseModel], Error>) -> Void ) {
//        var subscribedCourses: [CourseModel] = []
//        for id in coursesID {
//            self.database.collection(self.collection).whereField("id", isEqualTo: id)
//                .addSnapshotListener { query, error in
//                    if let error = error {
//                        completionBlock(.failure(error)) // To return Error case
//                        return
//                    }
//                    guard let documents = query?.documents.compactMap({ $0 }) else {
//                        completionBlock(.success([])) // To return [CourseModel] array empty
//                        return
//                    }
//                    let course = documents.map { try? $0.data(as: CourseModel.self) }
//                        .compactMap { $0 } // To avoid nil values.
//                    subscribedCourses.append(course[0]) //Each iteration returns a 1 element array, so we take the index 0 each time
//                    completionBlock(.success(subscribedCourses)) // To return [CourseModel] array with data
//                }
//        }
//    }
//
//    func getCoursesByCreatorID(creatorID: String, completionBlock: @escaping (Result<[CourseModel], Error>) -> Void ){
//        self.database.collection(self.collection).whereField("creatorID", isEqualTo: creatorID)
//            .addSnapshotListener { query, error in
//                if let error = error {
//                    completionBlock(.failure(error)) // To return Error case
//                    return
//                }
//                guard let documents = query?.documents.compactMap({ $0 }) else {
//                    completionBlock(.success([])) // To return [CourseModel] array empty
//                    return
//                }
//                let courses = documents.map { try? $0.data(as: CourseModel.self) }
//                    .compactMap { $0 } // To avoid nil values.
//                completionBlock(.success(courses)) // To return [CourseModel] array with data
//            }
//    }
//

//
//    func updateCourseData(courseID: String, title: String, description: String, imageURL: String, category: String,
//                          completionBlock: @escaping (Error) -> Void ) {
//        let currentDocument = self.database.collection(self.collection).document(courseID)
//        //Setting new document with the data given by the user
//        currentDocument.setData( ["title": title,
//                                  "description": description,
//                                  "imageURL": imageURL,
//                                  "category": category
//                                 ] ) { error in
//            if let error = error {
//                completionBlock(error)
//                return
//            }
//        }
//    }
//

//}
