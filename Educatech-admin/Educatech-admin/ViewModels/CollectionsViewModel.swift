//
//  CollectionsAuthViewModel.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 21/9/23.
//

import SwiftUI
import PhotosUI

final class CollectionsViewModel: ObservableObject {
    
    //Published variables about users
    @Published var allUsers: [UserDataModel] = []
    @Published var singleUser: UserDataModel = UserDataModel()
    
    //Published variables to store locally data from courses
    @Published var allCourses: [CourseModel] = []
    @Published var singleCourse: CourseModel = CourseModel()
    @Published var errorReceivingData: String?
    
    private let collectionsRepository: CollectionsRepository
    
    init(collectionsRepository: CollectionsRepository = CollectionsRepository()){
        self.collectionsRepository = collectionsRepository
        getAllUsers()
        getAllCourses()
    }
    
    //MARK: Get data
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
    
    //MARK: Edit data
    func editCourseData(changeTo course: CourseModel) {
        self.errorReceivingData = nil
        collectionsRepository.editCourseData(changeTo: course) { result in
            switch result {
            case .success(_):
                print("Edit course data ok")
            case .failure(_):
                print("Edit course data nok")
            }
        }
    }
    
    func editUserData(changeTo user: UserDataModel) {
        self.errorReceivingData = nil
        collectionsRepository.editUserData(changeTo: user) { result in
            switch result {
            case .success(_):
                print("Edit user data ok")
            case .failure(_):
                print("Edit user data nok")
            }
        }
    }
}
