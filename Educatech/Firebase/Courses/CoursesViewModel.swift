//
//  CoursesViewModel.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 21/9/23.
//

import Foundation

final class CoursesViewModel: ObservableObject {
    
    @Published var allCourses: [CourseModel] = []
    @Published var managedCourses: [CourseModel] = []
    @Published var error: String?
    
    private let coursesRepository: CoursesRepository
    
    init(coursesRepository: CoursesRepository = CoursesRepository()){
        self.coursesRepository = coursesRepository
    }
    
    func getAllCourses() {
        self.error = nil
        coursesRepository.getNewCourses { [weak self] result in
            switch result {
            case .success(let courses):
                self?.allCourses = courses
            case .failure(let error):
                self?.error = error.localizedDescription
            }
        }
    }
    
    func getCoursesByCreatorID(creatorID: String){
        self.error = nil
        coursesRepository.getCoursesByCreatorID(creatorID: creatorID) { [weak self] result in
            switch result {
            case .success(let courses):
                self?.managedCourses = courses
            case .failure(let error):
                self?.error = error.localizedDescription
            }
        }
    }
    
    func createNewCourse(title: String, description: String, image: String, creatorID: String) {
        self.error = nil
        guard courseValidations(title, description, image) else {
            return
        }
        coursesRepository.createNewCourse(title: title,
                                          description: description,
                                          image: image,
                                          creatorID: creatorID) { [weak self] result in
            switch result {
            case .success(let course):
                print("Course \(course.title) successfully created")
                //                self?.courses.append(course)
            case .failure(let error):
                self?.error = error.localizedDescription
            }
        }
    }
    
    func updateCourseData(creatorID: String, courseID: String, title: String, description: String, imageURL: String) {
        self.error = nil
        guard courseValidations(title, description, imageURL) else {
            return
        }
        coursesRepository.updateCourseData(creatorID: creatorID,
                                           courseID: courseID,
                                           title: title,
                                           description: description,
                                           imageURL: imageURL) { [weak self] error in
            self?.error = error.localizedDescription
        }
    }
    
    // MARK: Private functinos for the View Model
    private func courseValidations(_ title: String, _ description: String, _ image: String) -> Bool {
        guard title.validateNotEmptyString().isValid else {
            self.error = title.validateNotEmptyString().errorMsg
            return false
        }
        guard description.validateNotEmptyString().isValid else {
            self.error = description.validateNotEmptyString().errorMsg
            return false
        }
        guard image.validateNotEmptyString().isValid else {
            self.error = image.validateNotEmptyString().errorMsg
            return false
        }
        guard image.validateURLString().isValid else {
            self.error = image.validateURLString().errorMsg
            return false
        }
        return true
    }
    
}
