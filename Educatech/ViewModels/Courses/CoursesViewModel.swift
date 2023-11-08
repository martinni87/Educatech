//
//  CoursesViewModel.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 21/9/23.
//

import Foundation

final class CoursesViewModel: ObservableObject {
    
    //Published variables to register errors in the creation process of a new course (in form view).
    @Published var titleErrorMsg: String?
    @Published var descriptionErrorMsg: String?
    @Published var imageURLErrorMsg: String?
    @Published var categoryErrorMsg: String?
    @Published var videosURLErrorMsg: String?
    @Published var allowContinue: Bool = false
    
    
    private let coursesRepository: CoursesRepository
    
    init(coursesRepository: CoursesRepository = CoursesRepository()){
        self.coursesRepository = coursesRepository
    }
    
    func cleanCreationCache() {
        self.titleErrorMsg = nil
        self.descriptionErrorMsg = nil
        self.imageURLErrorMsg = nil
        self.categoryErrorMsg = nil
        self.videosURLErrorMsg = nil
        self.allowContinue = false
    }
    
    //MARK: Course creation form validations
    func creationFormValidations(_ formInputs: CreateCourseFormInputs) {
        formInputs.title.fieldIsNotEmpty { [weak self] isValid, errorMsg in
            if !isValid {
                self?.titleErrorMsg = errorMsg
                return
            }
            self?.titleErrorMsg = nil
            formInputs.imageURL.validateURLString { [weak self] isValid, errorMsg in
                if !isValid {
                    self?.imageURLErrorMsg = errorMsg
                    return
                }
                self?.imageURLErrorMsg = nil
                self?.allowContinue = true
            }
        }
    }
}

//
//    @Published var allCourses: [CourseModel] = []
//    @Published var managedCourses: [CourseModel] = []
//    @Published var subscribedCourses: [CourseModel] = []
//    @Published var error: String?
//    
//    private let coursesRepository: CoursesRepository
//    
//    init(coursesRepository: CoursesRepository = CoursesRepository()){
//        self.coursesRepository = coursesRepository
//    }
//    
//    func getAllCourses() {
//        self.error = nil
//        coursesRepository.getNewCourses { [weak self] result in
//            switch result {
//            case .success(let courses):
//                self?.allCourses = courses
//            case .failure(let error):
//                self?.error = error.localizedDescription
//            }
//        }
//    }
//    
//    func getSubscribedCoursesByIDList(coursesID: [String]) {
//        self.error = nil
//        coursesRepository.getSubscribedCoursesByIDList(coursesID: coursesID) { [weak self] result in
//            switch result {
//            case .success(let courses):
//                self?.subscribedCourses = courses
//            case .failure(let error):
//                self?.error = error.localizedDescription
//            }
//        }
//    }
//    
//    func getCoursesByCreatorID(creatorID: String){
//        self.error = nil
//        coursesRepository.getCoursesByCreatorID(creatorID: creatorID) { [weak self] result in
//            switch result {
//            case .success(let courses):
//                self?.managedCourses = courses
//            case .failure(let error):
//                self?.error = error.localizedDescription
//            }
//        }
//    }
//    
//    func createNewCourse(title: String, description: String, imageURL: String, creatorID: String, teacher: String, category: String/*, price: Double*/) {
//        self.error = nil
//        guard courseValidations(title,description,imageURL,category/*,price*/) else {
//            return
//        }
//        coursesRepository.createNewCourse(title: title,
//                                          description: description,
//                                          imageURL: imageURL,
//                                          creatorID: creatorID,
//                                          teacher: teacher,
//                                          category: category/*,*/
//                                          /*price: price*/) { [weak self] result in
//            switch result {
//            case .success(let course):
//                print("Course \(course.title) successfully created")
//            case .failure(let error):
//                self?.error = error.localizedDescription
//            }
//        }
//    }
//    
//    func updateCourseData(courseID: String, title: String, description: String, imageURL: String, category: String/*, price: Double*/) {
//        self.error = nil
//        guard courseValidations(title,description,imageURL,category/*,price*/) else {
//            return
//        }
//        coursesRepository.updateCourseData(courseID: courseID,
//                                           title: title,
//                                           description: description,
//                                           imageURL: imageURL,
//                                           category: category/*,*/
//                                           /*price: price*/) { [weak self] error in
//            self?.error = error.localizedDescription
//        }
//    }
//    
//    // MARK: Private functinos for the View Model
//    private func courseValidations(_ title: String, _ description: String, _ imageURL: String, _ category: String/*, _ price: Double?*/) -> Bool {
//        guard title.validateNotEmptyString().isValid else {
//            self.error = title.validateNotEmptyString().errorMsg
//            return false
//        }
//        guard description.validateNotEmptyString().isValid else {
//            self.error = description.validateNotEmptyString().errorMsg
//            return false
//        }
//        guard imageURL.validateNotEmptyString().isValid else {
//            self.error = imageURL.validateNotEmptyString().errorMsg
//            return false
//        }
//        guard imageURL.validateURLString().isValid else {
//            self.error = imageURL.validateURLString().errorMsg
//            return false
//        }
//        guard category.validateNotEmptyString().isValid else {
//            self.error = category.validateNotEmptyString().errorMsg
//            return false
//        }
////        guard price != nil else {
////            self.error = "".validateNotEmptyString().errorMsg
////            return false
////        }
//        return true
//    }
//    
//}
