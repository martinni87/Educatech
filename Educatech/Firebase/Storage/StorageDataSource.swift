//
//  StorageDataSource.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 28/9/23.
//

import Foundation
import Firebase
import FirebaseStorage

final class StorageDataSource {
    
    private let storageRef = Storage.storage().reference(forURL: "gs://courses")
    
    
    func uploadImage(courseID: String, imagePath: String, completionBlock: @escaping (Result<String, Error>) -> Void) {
        // Create course folder and reference for new file
        let newCourseRef = storageRef.child("\(courseID)")
        let newFileRef = newCourseRef.child("\(courseID)_pic.jpg")
        let fileToLoad = URL(string: imagePath)!
        // Upload method
        newFileRef.putFile(from: fileToLoad) { _, error in
            if let error = error {
                completionBlock(.failure(error))
                return
            }
        }
    }
}
