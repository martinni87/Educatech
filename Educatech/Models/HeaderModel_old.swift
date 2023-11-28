//
//  HeaderModel.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 29/10/23.
//

import SwiftUI

enum HeaderType: String {
    case initial = "Educatech"
    case register1 = "Start Register"
    case register2 = "Register Form"
    case register3 = "Your interests"
    case register4 = "Checking engines!"
    case login = "Login"
    case createcourse1 = "Create a new course"
    case createcourse2 = "Creation form"
    case createcourse3 = "Description"
    case createcourse4 = "Upload your videos"
    case createcourse5 = "Everything's good?"
    case editCourse = "Edit course"
}

final class HeaderModel {
    let headerType: HeaderType
    let title: String
    let titleColor: Color
    let subtitle: String
    let subtitleColor: Color
    let image: String
    
    init(headerType: HeaderType) {
        self.headerType = headerType
        self.title = headerType.rawValue
        self.subtitleColor = .gray
        
        switch headerType {
        case .initial:
            self.titleColor = Color(.sRGB, red: 0.15, green: 0.50, blue: 0.75, opacity: 0.9)
            self.subtitle = "A whole universe of knowlegde right from your pocket"
            self.image = "AppLogo"
        case .register1:
            self.titleColor = Color("color_text_standard")
            self.subtitle = "Welcome and thanks for choosing Educatech! To sign up a new account click next and follow all steps."
            self.image = "form_register_pic1"
        case .register2:
            self.titleColor = Color("color_text_standard")
            self.subtitle = "Fill the form, check the data is valid and tap 'Next'."
            self.image = "form_register_pic2"
        case .register3:
            self.titleColor = Color("color_text_standard")
            self.subtitle = "Now we need some clues about what you'd like to learn!"
            self.image = "form_register_pic3"
        case .register4:
            self.titleColor = Color("color_text_standard")
            self.subtitle = "We're almost there! Last check! If everything's ok, hit 'Register'"
            self.image = "form_register_pic4"
        case .login:
            self.titleColor = Color("color_text_standard")
            self.subtitle = "Access with your current credentials"
            self.image = "form_login_pic"
        case .createcourse1:
            self.titleColor = Color("color_text_standard")
            self.subtitle = "Do you want to contribute with a bit of knowledge? Start creating a new course and make the world a little smarter! 🚀"
            self.image = "form_create_course_pic1"
        case .createcourse2:
            self.titleColor = Color("color_text_standard")
            self.subtitle = "Here you can fill basic information of what you offer."
            self.image = "form_create_course_pic2"
        case .createcourse3:
            self.titleColor = Color("color_text_standard")
            self.subtitle = "Describe with a few words what are students going to learn."
            self.image = "form_create_course_pic3"
        case .createcourse4:
            self.titleColor = Color("color_text_standard")
            self.subtitle = "This is the list of videos you're going to include in your course. Copy and paste the URL where you store each video."
            self.image = "form_create_course_pic4"
        case .createcourse5:
            self.titleColor = Color("color_text_standard")
            self.subtitle = "Last check! If everything is fine, hit create to upload your course."
            self.image = "form_create_course_pic5"
        case .editCourse:
            self.titleColor = Color("color_text_standard")
            self.subtitle = "Edit the info of your course, the thumbnail picture, or the videos. Enjoy!"
            self.image = "form_video-editing"
        }
    }
}
