//
//  ProviderModel.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 23/10/23.
//

import SwiftUI

enum ProviderType: String {
    case email = "Email"
    case facebook = "Facebook"
    case google = "Google"
    case apple = "Apple"
}

final class ProviderModel {
    private let colorScheme: ColorScheme
    private let type: ProviderType
    let title: String
    let backgroundColor: Color
    let titleColor: Color
    let icon: String
    
    init(colorScheme: ColorScheme, type: ProviderType){
        self.colorScheme = colorScheme
        self.type = type
        switch type {
        case .email:
            self.title = "Email"
            self.backgroundColor = Color("AccentColor")
            self.titleColor = .white
            self.icon = "icon_email"
        case .facebook:
            self.title = "Facebook"
            self.backgroundColor = Color("color_facebook_background")
            self.titleColor = .white
            self.icon = "icon_facebook"
        case .google:
            self.title = "Google"
            self.backgroundColor = Color("color_google_background")
            self.titleColor = colorScheme == .light ? .black : .white
            self.icon = "icon_google"
        case .apple:
            self.title = "Apple"
            self.backgroundColor = Color("color_apple_background")
            self.titleColor = colorScheme == .light ? .white : .black
            self.icon = "icon_apple"
        }
    }
}
