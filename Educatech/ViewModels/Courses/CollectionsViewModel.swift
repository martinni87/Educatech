//
//  CollectionsAuthViewModel.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 21/9/23.
//

import Foundation

final class CollectionsViewModel: ObservableObject {
    
    //Published variables to register errors in the creation process of a new course (in form view).
    @Published var creationMsg: String = ""
    @Published var titleErrorMsg: String?
    @Published var descriptionErrorMsg: String?
    @Published var imageURLErrorMsg: String?
    @Published var creationWasSuccessful: Bool = false
    @Published var creationHasFailed: Bool = false
    @Published var allowContinue: Bool = false
    
    //Published variables to store locally data from courses
    @Published var allCourses: [CourseModel] = []
    @Published var managedCourses: [CourseModel] = []
    @Published var recommendedCourses: [String: [CourseModel]] = [:]
    @Published var errorReceivingData: String?
    
    private let coursesRepository: CollectionsRepository
    
    init(coursesRepository: CollectionsRepository = CollectionsRepository()){
        self.coursesRepository = coursesRepository
        getAllCourses()
    }
    
    func cleanCreationCache() {
        self.creationMsg = ""
        self.titleErrorMsg = nil
        self.descriptionErrorMsg = nil
        self.imageURLErrorMsg = nil
        self.creationWasSuccessful = false
        self.creationHasFailed = false
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
    
    //MARK: Courses data from database
    func getAllCourses() {
        coursesRepository.getAllCourses { [weak self] result in
            switch result {
            case .success(let courses):
                self?.allCourses = courses
            case .failure(let error):
                self?.errorReceivingData = error.localizedDescription
            }
        }
    }
    
    func getCoursesByCreatorID(creatorID: String){
        coursesRepository.getCoursesByCreatorID(creatorID: creatorID) { [weak self] result in
            switch result {
            case .success(let courses):
                self?.managedCourses = courses
            case .failure(let error):
                self?.errorReceivingData = error.localizedDescription
            }
        }
    }
    
    func getCoursesByCategory(categories: [String]) {
        for category in categories {
            coursesRepository.getCoursesByCategory(category: category) { [weak self] result in
                switch result {
                case .success(let courses):
                    self?.recommendedCourses[category] = courses
                case .failure(let error):
                    self?.errorReceivingData = error.localizedDescription
                }
            }
        }
    }
    
    func createNewCourse(formInputs: CreateCourseFormInputs, userData: UserDataModel) {
        coursesRepository.createNewCourse(formInputs: formInputs, userData: userData) { [weak self] result in
            switch result {
            case .success(let newCourse):
                self?.creationMsg = "New \(newCourse.title) course have been created successfully"
                self?.creationWasSuccessful = true
            case .failure(let error):
                self?.creationMsg = error.localizedDescription
                self?.creationHasFailed = true
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
