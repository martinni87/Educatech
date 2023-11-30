//
//  CollectionsRepository.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 21/9/23.
//

import SwiftUI
import PhotosUI

final class CollectionsRepository {
    
    private let collectionsDataSource: CollectionsDataSource
    
    init(coursesDataSource: CollectionsDataSource = CollectionsDataSource()) {
        self.collectionsDataSource = coursesDataSource
    }
    
    func getAllCourses(completionBlock: @escaping (Result<[CourseModel], Error>) -> Void ){
        collectionsDataSource.getAllCourses(completionBlock: completionBlock)
    }
    
    func getCourseByID(courseID: String, completionBlock: @escaping (Result<CourseModel, Error>) -> Void) {
        collectionsDataSource.getCourseByID(courseID: courseID, completionBlock: completionBlock)
    }
    
    func getCoursesByCreatorID(creatorID: String, completionBlock: @escaping (Result<[CourseModel], Error>) -> Void ){
        collectionsDataSource.getCoursesByCreatorID(creatorID: creatorID, completionBlock: completionBlock)
    }
    
    func getCoursesByCategory(category: String, completionBlock: @escaping(Result<[CourseModel], Error>) -> Void) {
        collectionsDataSource.getCoursesByCategory(category: category, completionBlock: completionBlock)
    }
    
    func createNewCourse(formInputs: CreateCourseFormInputs, userData: UserDataModel, completionBlock: @escaping (Result<CourseModel, Error>) -> Void ) {
        collectionsDataSource.createNewCourse(formInputs: formInputs, userData: userData, completionBlock: completionBlock)
    }
    
    func editCourseData(changeTo course: CourseModel, completionBlock: @escaping (Result<CourseModel, Error>) -> Void) {
        collectionsDataSource.editCourseData(changeTo: course, completionBlock: completionBlock)
    }
    
    func addNewVideoListToCourse(course: CourseModel, newVideosList: [PhotosPickerItem], completionBlock: @escaping (Result<CourseModel, Error>) -> Void ) {
        collectionsDataSource.addNewVideoListToCourse(course: course, newVideosList: newVideosList, completionBlock: completionBlock)
    }
    
}
