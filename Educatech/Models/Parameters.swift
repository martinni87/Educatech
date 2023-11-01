//
//  FormParameters.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 16/10/23.
//

import Foundation

struct RegisterFormParams {
    
}

struct CreationFormParameters {
    var title: String = ""
    var description: String = ""
    var imageURL: String = ""
    var category: String = ""
//    var price: String = "0.00"
}

struct ErrorParameters {
    var showMsg: Bool = false
    var thereIsError: Bool = false
    var message: String = "New course created successfully! 😎"
}
