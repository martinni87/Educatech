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
            self.subtitle = "Welcome! And thanks for choosing Educatech. To sign up a new account swipe right"
            self.image = "form_register_pic1"
        case .register2:
            self.titleColor = Color("color_text_standard")
            self.subtitle = "Fill the form and when you're ready swipe right!"
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
        }
    }
}
