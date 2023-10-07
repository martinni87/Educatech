//
//  AppErrors.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 22/9/23.
//

import Foundation

enum AppErrors: String, Error {
    case none = "Success"
    case fieldIsEmpty = "All fields are mandatory"
    case badURL = "The URL is badly formed"
    case authError = "Something went wrong during authentication process. If the problem persists, please contact support."
}

