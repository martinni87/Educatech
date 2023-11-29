//
//  CollectionsAuthViewModel.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 21/9/23.
//

import SwiftUI
import PhotosUI

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
    
    //Published variables about users
    @Published var allUsers: [UserDataModel] = []
    @Published var singleUser: UserDataModel = UserDataModel()
    
    //Published variables to store locally data from courses
    @Published var allCourses: [CourseModel] = []
    @Published var managedCourses: [CourseModel] = []
    @Published var subscribedCourses: [CourseModel] = []
    @Published var recommendedCourses: [String: [CourseModel]] = [:]
    @Published var searchResults: [CourseModel] = []
    @Published var searchHasEmptyResult: Bool = false
    @Published var errorReceivingData: String?
    @Published var deletionErrorMsg: String?
    
    //Published value to load current course updates
    @Published var singleCourse: CourseModel = CourseModel(creatorID: "", teacher: "", title: "", description: "", imageURL: "")
    
    private let collectionsRepository: CollectionsRepository
    
    init(collectionsRepository: CollectionsRepository = CollectionsRepository()){
        self.collectionsRepository = collectionsRepository
        getAllUsers()
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
    
    //MARK: Users from database
    func getAllUsers(){
        collectionsRepository.getAllUsers { [weak self] result in
            switch result {
            case .success(let users):
                self?.allUsers = users
            case .failure(let error):
                self?.errorReceivingData = error.localizedDescription
            }
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
    
    func getSubscribedCoursesByID(coursesIDs: [String]) {
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
    
    func editUserData(changeTo user: UserDataModel) {
        self.errorReceivingData = nil
        collectionsRepository.editUserData(changeTo: user) { [weak self] result in
            switch result {
            case .success(let userEdited):
                self?.singleUser = userEdited
            case .failure(let error):
                self?.errorReceivingData = error.localizedDescription
            }
        }
    }
}
