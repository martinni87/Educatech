//
//  StorageViewModel.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 1/10/23.
//

import Foundation
import Firebase
import FirebaseStorage

final class StorageViewModel: ObservableObject {
    
    private let storageRepository = StorageRepository()
    @Published var message: String?
    
    
    func uploadImage(courseID: String, imagePath: String) {
        storageRepository.uploadImage(courseID: courseID, imagePath: imagePath) { [weak self] result in
            switch result {
            case .success(_):
                self?.message = "Upload was successfully"
            case .failure(let error):
                self?.message = error.localizedDescription
            }
        }
    }
}
