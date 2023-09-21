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
    
    func getAllVideos(completionBlock: @escaping (Result<[CourseModel], Error>) -> Void ){
        coursesDataSource.getAllCourses(completionBlock: completionBlock)
    }
    
}
