//
//  CoursesRepository.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 21/9/23.
//

import Foundation

final class CoursesRepository {
    
    private let coursesDataSource: CoursesDataSource
    
    init(coursesDataSource: CoursesDataSource = CoursesDataSource()) {
        self.coursesDataSource = coursesDataSource
    }
    
    func getNewCourses(completionBlock: @escaping (Result<[CourseModel], Error>) -> Void ){
        coursesDataSource.getAllCourses(completionBlock: completionBlock)
    }
    
    func getCoursesByCreatorID(creatorID: String, completionBlock: @escaping (Result<[CourseModel], Error>) -> Void ){
        coursesDataSource.getCoursesByCreatorID(creatorID: creatorID, completionBlock: completionBlock)
    }
    
    func createNewCourse(title: String, description: String, image: String, creatorID: String, completionBlock: @escaping (Result<CourseModel, Error>) -> Void ) {
        coursesDataSource.createNewCourse(title: title, description: description, imageURL: image, creatorID: creatorID, completionBlock: completionBlock)
    }

}
