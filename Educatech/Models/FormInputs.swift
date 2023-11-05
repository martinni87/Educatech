//
//  FormInputs.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 16/10/23.
//

import Foundation

enum Categories: String, Identifiable {
    case mobile = "Mobile Development"
    case web = "Web Development"
    case testing = "Testing & QA"
    case datasc = "Data Science"
    case mlearning = "Machine Learning"
    case languagePython = "Python"
    case languageSwift = "Swift"
    case languageObjc = "Objective-C"
    case languageJava = "Java"
    case languageKotlin = "Kotlin"
    case languageJS = "JavaScript"
    case uxui = "UX/UI"
    case css = "CSS"
    case html = "HTML"
    
    var id: String {
        return rawValue
    }
}

let CATEGORIES: [Categories] = [
    .mobile, .web, .testing, .datasc, .mlearning, .languagePython, .languageSwift,
    .languageObjc, .languageJava, .languageKotlin, .uxui, .html, .css, .languageJS
]

struct RegistrationFormInputs {
    var email: String = ""
    var username: String = ""
    var password: String = ""
    var repeatPassword: String = ""
    var categories: Set<Categories> = []
}
//
//struct LoginFormInputs {
//    var email: String = ""
//    var password: String = ""
//}





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
