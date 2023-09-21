//
//  CoursesViewModel.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 21/9/23.
//

import Foundation

final class CoursesViewModel: ObservableObject {
    
    @Published var courses: [CourseModel] = []
    @Published var error: Error?
    
    private let coursesRepository: CoursesRepository
    
    init(coursesRepository: CoursesRepository = CoursesRepository()){
        self.coursesRepository = coursesRepository
    }
    
    func getAllVideos() {
        coursesRepository.getAllVideos { [weak self] result in
            switch result {
            case .success(let courses):
                self?.courses = courses
            case .failure(let error):
                self?.error = error
            }
        }
    }
    
}
