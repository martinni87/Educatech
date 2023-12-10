//
//  FormInputs.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 16/10/23.
//

import SwiftUI
import PhotosUI

/**
 Enum representing categories for educational content.

 - Note: The `id` property is implemented for `Identifiable` conformance.
 - Important: The raw value of each case represents the category name.
 */
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
    
    /// The unique identifier for each category, which is the raw value.
    var id: String {
        return rawValue
    }
}

/// Lorem Ipsum text for placeholder content.
let LOREMIPSUM = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
"""

/**
 Structure representing input fields for user registration.

 - Note: Each property represents a form input field for registration.
 */
struct RegistrationFormInputs {
    var email: String = ""
    var username: String = ""
    var password: String = ""
    var repeatPassword: String = ""
    var categories: [String] = []
}

/**
 Structure representing input fields for user login.

 - Note: Each property represents a form input field for login.
 */
struct LoginFormInputs {
    var email: String = ""
    var password: String = ""
}

/**
 Structure representing input fields for creating a new course.

 - Note: Each property represents a form input field for course creation.
 */
struct CreateCourseFormInputs {
    var creatorID: String = ""
    var teacher: String = ""
    var title: String = ""
    var description: String = ""
    var selectedPicture: PhotosPickerItem? = nil
    var imageURL: String = ""
    var category: String = ""
    var selectedVideos: [PhotosPickerItem] = []
}

/**
 Structure representing search input and results.

 - Note: Each property represents a field related to searching educational content.
 */
struct SearchIO {
    var isNewSearch = true
    var thereAreResults = false
    var search: String = ""
    var category: String = ""
}
