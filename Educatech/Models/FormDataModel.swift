//
//  FormInputs.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 16/10/23.
//

import Foundation

enum Categories: String, CaseIterable, Identifiable, Decodable {
    case none = ""
    case html = "HTML"
    case css = "CSS"
    case uxui = "UX/UI"
    case languageJS = "JavaScript"
    case languageJava = "Java"
    case languageKotlin = "Kotlin"
    case languageSwift = "Swift"
    case languageObjc = "Objective-C"
    case languagePython = "Python"
    case mobile = "Mobile Development"
    case web = "Web Development"
    case testing = "Testing & QA"
    case datasc = "Data Science"
    case mlearning = "Machine Learning"
    
    var id: String {
        return rawValue
    }
}

let LOREMIPSUM = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
"""

struct RegistrationFormInputs {
    var email: String = ""
    var username: String = ""
    var password: String = ""
    var repeatPassword: String = ""
    var categories: [String] = []
}

struct LoginFormInputs {
    var email: String = ""
    var password: String = ""
}

struct CreateCourseFormInputs {
    var creatorID: String = ""
    var teacher: String = ""
    var title: String = ""
    var description: String = ""
    var imageURL: String = ""
    var category: String = ""
    var videosURL: [String] = []
}

struct SearchIO {
    var isNewSearch = true
    var thereAreResults = false
    var search: String = ""
    var category: String = ""
}


////struct ErrorParameters {
////    var showMsg: Bool = false
////    var thereIsError: Bool = false
////    var message: String = "New course created successfully! 😎"
////}
//
//struct CreateCourseFormInputs {
//    var title: String = ""
//    var description: String = ""
//    var imageURL: String = ""
//    var category: String = ""
//}




//import Foundation
//
//struct RegisterFormParams {
//    
//}
//
//struct CreationFormParameters {
//    var title: String = ""
//    var description: String = ""
//    var imageURL: String = ""
//    var category: String = ""
////    var price: String = "0.00"
//}
//
//struct ErrorParameters {
//    var showMsg: Bool = false
//    var thereIsError: Bool = false
//    var message: String = "New course created successfully! 😎"
//}
