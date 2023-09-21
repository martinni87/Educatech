//
//  CourseModel.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 21/9/23.
//

import Foundation
import FirebaseFirestoreSwift


struct CourseModel: Decodable, Identifiable, Hashable {
    @DocumentID var id: String?
    let title: String
    let description: String
    let image: String //The route in which is stored

}
