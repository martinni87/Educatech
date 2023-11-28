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
    @Published var categoryErrorMsg: String?
    @Published var creationWasSuccessful: Bool = false
    @Published var creationHasFailed: Bool = false
    @Published var allowContinue: Bool = false
    
    //Published variables to store locally data from courses
    @Published var allCourses: [CourseModel] = []
    @Published var managedCourses: [CourseModel] = []
    @Published var subscribedCourses: [CourseModel] = []
    @Published var recommendedCourses: [String: [CourseModel]] = [:]
    @Published var searchResults: [CourseModel] = []
    @Published var searchHasEmptyResult: Bool = false
    @Published var errorReceivingData: String?
    
    //Published value to load current course updates
    @Published var singleCourse: CourseModel = CourseModel(creatorID: "", teacher: "", title: "", description: "", imageURL: "")
    
    private let collectionsRepository: CollectionsRepository
    
    init(collectionsRepository: CollectionsRepository = CollectionsRepository()){
        self.collectionsRepository = collectionsRepository
        getAllCourses()
    }
    
    func cleanCollectionsCache() {
        //Form input msgs
        self.creationMsg = ""
        self.titleErrorMsg = nil
        self.descriptionErrorMsg = nil
        self.imageURLErrorMsg = nil
        self.categoryErrorMsg = nil
        //Form input flags
        self.creationWasSuccessful = false
        self.creationHasFailed = false
        self.allowContinue = false
        self.searchHasEmptyResult = false
        //Errors receiving data from firestore
        self.errorReceivingData = nil
    }
    
    //MARK: Course creation form validations
    func creationFormValidations(_ formInputs: CreateCourseFormInputs) {
        formInputs.title.validateTitle { [weak self] isValid, errorMsg in
            if !isValid {
                self?.titleErrorMsg = errorMsg
                return
            }
            self?.titleErrorMsg = nil
            if formInputs.selectedPicture == nil {
                self?.imageURLErrorMsg = "You must select a picture from your photo gallery"
                return
            }
            self?.imageURLErrorMsg = nil
            formInputs.category.fieldIsNotEmpty { isValid, errorMsg in
                if !isValid {
                    self?.categoryErrorMsg = errorMsg
                    return
                }
                self?.allowContinue = true
            }
        }
    }
    
    func validateTitleInEditionForm(_ formInputs: CreateCourseFormInputs) {
        formInputs.title.validateTitle { [weak self] isValid, errorMsg in
            if !isValid {
                self?.titleErrorMsg = errorMsg
                return
            }
            self?.titleErrorMsg = nil
            self?.allowContinue = true
        }
    }
    
    //MARK: Courses data from database
    func getAllCourses() {
        collectionsRepository.getAllCourses { [weak self] result in
            switch result {
            case .success(let courses):
                self?.allCourses = courses
            case .failure(let error):
                self?.errorReceivingData = error.localizedDescription
            }
        }
    }
    
    func getSingleCourseByID(courseID: String) {
        collectionsRepository.getCourseByID(courseID: courseID) { [weak self] result in
            switch result {
            case .success(let course):
                self?.singleCourse = course
            case .failure(let error):
                self?.errorReceivingData = error.localizedDescription
            }
        }
    }
    
    func getCoursesByID(coursesIDs: [String]) {
        //Each time it's called, we clean the array
        self.subscribedCourses = []
        //Then we repopulate it with all the id's of courses the user has
        for courseID in coursesIDs {
            collectionsRepository.getCourseByID(courseID: courseID) { [weak self] result in
                switch result {
                case .success(let course):
                    self?.subscribedCourses.append(course)
                case .failure(let error):
                    self?.errorReceivingData = error.localizedDescription
                }
            }
        }
    }
    
    func getCoursesByCreatorID(creatorID: String){
        collectionsRepository.getCoursesByCreatorID(creatorID: creatorID) { [weak self] result in
            switch result {
            case .success(let courses):
                self?.managedCourses = courses
            case .failure(let error):
                self?.errorReceivingData = error.localizedDescription
            }
        }
    }
    
    func getCoursesByCategories(categories: [String]) {
        for category in categories {
            collectionsRepository.getCoursesByCategory(category: category) { [weak self] result in
                switch result {
                case .success(let courses):
                    self?.recommendedCourses[category] = courses
                case .failure(let error):
                    self?.errorReceivingData = error.localizedDescription
                }
            }
        }
    }
    
    func getCoursesByCategory(category: String){
        if category == "" {
            collectionsRepository.getAllCourses { [weak self] result in
                switch result {
                case .success(let courses):
                    if courses.isEmpty {
                        self?.searchHasEmptyResult = true
                        self?.searchResults = []
                    }
                    else {
                        self?.searchHasEmptyResult = false
                        self?.searchResults = courses
                    }
                case .failure(let error):
                    self?.searchHasEmptyResult = true
                    self?.searchResults = []
                    self?.errorReceivingData = error.localizedDescription
                }
            }
        }
        else {
            collectionsRepository.getCoursesByCategory(category: category) { [weak self] result in
                switch result {
                case .success(let courses):
                    if courses.isEmpty {
                        self?.searchHasEmptyResult = true
                        self?.searchResults = []
                    }
                    else {
                        self?.searchHasEmptyResult = false
                        self?.searchResults = courses
                    }
                case .failure(let error):
                    self?.searchHasEmptyResult = true
                    self?.searchResults = []
                    self?.errorReceivingData = error.localizedDescription
                }
            }
        }
    }
    
    func createNewCourse(formInputs: CreateCourseFormInputs, userData: UserDataModel) {
        collectionsRepository.createNewCourse(formInputs: formInputs, userData: userData) { [weak self] result in
            switch result {
            case .success(let newCourse):
                self?.creationMsg = "New \(newCourse.title) course have been created successfully. A moderator will review the content and when validated, it will appear in the Home section."
                self?.creationWasSuccessful = true
            case .failure(let error):
                self?.creationMsg = error.localizedDescription
                self?.creationHasFailed = true
            }
        }
    }
    
    func changeNumberOfStudents(courseID: String, variation: Int) {
        collectionsRepository.changeNumberOfStudents(courseID: courseID, variation: variation) { [weak self ] result in
            switch result {
            case .success(_):
                print("Course updated")
                self?.getAllCourses() //Update all courses list when number of students is updated
            case .failure(let error):
                self?.errorReceivingData = error.localizedDescription
            }
        }
    }
    
    func editCourseData(changeTo course: CourseModel) {
        self.errorReceivingData = nil
        collectionsRepository.editCourseData(changeTo: course) { [weak self] result in
            switch result {
            case .success(let courseEdited):
                self?.singleCourse = courseEdited
            case .failure(let error):
                self?.errorReceivingData = error.localizedDescription
            }
        }
    }
}

//    func editExistingCourse(currentValues: CourseModel, newValues: CreateCourseFormInputs) {
//        // Validate title has no forbidden characters
//        let forbiddenCharacters = #"@/\\|\"'`´^*+<>ºª°¸˛…—·#$%&()"#
//        if newValues.title.rangeOfCharacter(from: CharacterSet(charactersIn: forbiddenCharacters)) != nil {
//            self.titleErrorMsg = "Title contains forbidden characters."
//            return
//        }
//        else {
//            collectionsRepository.editExistingCourse(currentValues: currentValues, newValues: newValues) { [weak self] result in
//                switch result {
//                case .success(let course):
//                    print(course.title)
//                case .failure(let error):
//                    self?.errorReceivingData = error.localizedDescription
//                }
//            }
//        }
//    }
//}

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
