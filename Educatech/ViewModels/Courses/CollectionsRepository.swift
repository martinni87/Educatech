//
//  CollectionsRepository.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 21/9/23.
//

import Foundation

final class CollectionsRepository {
    
    private let coursesDataSource: CollectionsDataSource
    
    init(coursesDataSource: CollectionsDataSource = CollectionsDataSource()) {
        self.coursesDataSource = coursesDataSource
    }
    
    func getAllCourses(completionBlock: @escaping (Result<[CourseModel], Error>) -> Void ){
        coursesDataSource.getAllCourses(completionBlock: completionBlock)
    }
    
    func createNewCourse(formInputs: CreateCourseFormInputs, userData: UserDataModel, completionBlock: @escaping (Result<CourseModel, Error>) -> Void ) {
        coursesDataSource.createNewCourse(formInputs: formInputs, userData: userData, completionBlock: completionBlock)
    }
    
    func getCoursesByCreatorID(creatorID: String, completionBlock: @escaping (Result<[CourseModel], Error>) -> Void ){
        coursesDataSource.getCoursesByCreatorID(creatorID: creatorID, completionBlock: completionBlock)
    }
    
}
//
//    func getNewCourses(completionBlock: @escaping (Result<[CourseModel], Error>) -> Void ){
//        coursesDataSource.getAllCourses(completionBlock: completionBlock)
//    }
//    
//    func getSubscribedCoursesByIDList(coursesID: [String], completionBlock: @escaping (Result<[CourseModel], Error>) -> Void ) {
//        coursesDataSource.getSubscribedCoursesByIDList(coursesID: coursesID,
//                                                       completionBlock: completionBlock)
//    }
//    
//    func getCoursesByCreatorID(creatorID: String, completionBlock: @escaping (Result<[CourseModel], Error>) -> Void ){
//        coursesDataSource.getCoursesByCreatorID(creatorID: creatorID,
//                                                completionBlock: completionBlock)
//    }
//    
//    func createNewCourse(title: String, description: String, imageURL: String, creatorID: String, teacher: String, category: String/*, price: Double*/,
//                         completionBlock: @escaping (Result<CourseModel, Error>) -> Void ) {
//        coursesDataSource.createNewCourse(title: title,
//                                          description: description,
//                                          imageURL: imageURL,
//                                          creatorID: creatorID,
//                                          teacher: teacher,
//                                          category: category,
//                                          //price: price,
//                                          completionBlock: completionBlock)
//    }
//    
//    func updateCourseData(courseID: String, title: String, description: String, imageURL: String, category: String, /*price: Double,*/
//                          completionBlock: @escaping (Error) -> Void ) {
//        coursesDataSource.updateCourseData(courseID: courseID,
//                                           title: title,
//                                           description: description,
//                                           imageURL: imageURL,
//                                           category: category,
//                                           //price: price,
//                                           completionBlock: completionBlock)
//    }
//
//}
