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

/// A class responsible for managing data source operations related to courses and users.
final class CollectionsDataSource {
    
    private let database = Firestore.firestore()
    private let coursesCollection = "courses"
    private let usersCollection = "users"
    
    /// Retrieves all courses from the Firestore database.
    ///
    /// - Parameter completionBlock: A completion block to handle the result of the operation.
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
    
    /// Retrieves a course by its ID from the Firestore database.
    ///
    /// - Parameters:
    ///   - courseID: The ID of the course to retrieve.
    ///   - completionBlock: A completion block to handle the result of the operation.
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
    
    /// Retrieves courses by the creator's ID from the Firestore database.
    ///
    /// - Parameters:
    ///   - creatorID: The ID of the course creator.
    ///   - completionBlock: A completion block to handle the result of the operation.
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
    
    /// Retrieves courses by category from the Firestore database.
    ///
    /// - Parameters:
    ///   - category: The category of the courses to retrieve.
    ///   - completionBlock: A completion block to handle the result of the operation.
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
    
    /// Creates a new course in the Firestore database.
    ///
    /// - Parameters:
    ///   - formInputs: The form inputs for creating the course.
    ///   - userData: The user data associated with the course creator.
    ///   - completionBlock: A completion block to handle the result of the operation.
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
                    
                    if !formInputs.selectedVideos.isEmpty {
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
    }
    
    /// Adds a new managed course to the user's data in the Firestore database.
    ///
    /// - Parameters:
    ///   - newCourse: The new course to be added.
    ///   - userData: The user data associated with the course creator.
    ///   - completionBlock: A completion block to handle the result of the operation.
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
    
    // MARK: Private and self methods
    /// Retrieves the count of documents in the Firestore database collection.
    ///
    /// - Parameter completionBlock: A completion block to handle the count.
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
    
    /// Edits the data of a course in the Firestore database.
    ///
    /// - Parameters:
    ///   - course: The course model to edit.
    ///   - completionBlock: A completion block to handle the result of the operation.
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
    
    /// Adds a new list of videos to a course in the Firestore database.
    ///
    /// - Parameters:
    ///   - course: The course model to which the videos will be added.
    ///   - newVideosList: The list of new videos to add.
    ///   - completionBlock: A completion block to handle the result of the operation.
    func addNewVideoListToCourse(course: CourseModel, newVideosList: [PhotosPickerItem], completionBlock: @escaping (Result<CourseModel, Error>) -> Void ) {
        newVideosList.enumerated().forEach { i, selectedVideo in
            StorageManager().uploadVideo(courseID: course.id!, selectedVideo: selectedVideo) { result in
                switch result {
                case .failure(let error):
                    completionBlock(.failure(error))
                    return
                case .success(_):
                    if i == newVideosList.count - 1 {
                        StorageManager().retrieveVideosList(courseID: course.id!) { result in
                            switch result {
                            case .failure(let error):
                                completionBlock(.failure(error))
                            case .success(let urlStringList):
                                let videosURL = urlStringList
                                
                                //Creating new collection with id
                                let document = self.database.collection(self.coursesCollection).document(course.id ?? "0")
                                
                                //Setting new document with the data given by the user
                                let editedCourse = CourseModel(id: course.id!,
                                                               creatorID: course.creatorID,
                                                               teacher: course.teacher,
                                                               title: course.title,
                                                               description: course.description,
                                                               imageURL: course.imageURL,
                                                               category: course.category,
                                                               videosURL: videosURL,
                                                               numberOfStudents: course.numberOfStudents,
                                                               approved: course.approved)
                                
                                document.setData( ["id": editedCourse.id!,
                                                   "creatorID": editedCourse.creatorID,
                                                   "teacher": editedCourse.teacher,
                                                   "title": editedCourse.title,
                                                   "description": editedCourse.description,
                                                   "imageURL": editedCourse.imageURL,
                                                   "category": editedCourse.category,
                                                   "videosURL": editedCourse.videosURL,
                                                   "numberOfStudents": editedCourse.numberOfStudents,
                                                   "approved": editedCourse.approved
                                                  ]) { error in
                                    if let error = error {
                                        completionBlock(.failure(error))
                                        return
                                    }
                                    completionBlock(.success(editedCourse))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
