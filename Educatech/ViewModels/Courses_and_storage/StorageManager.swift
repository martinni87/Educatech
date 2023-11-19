//
//  StorageDataSource.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 28/9/23.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseStorage

final class StorageManager {
    
    private let storage = Storage.storage().reference()
    
    func uploadPicture(courseID: String, photoItem: PhotosPickerItem, completionBlock: @escaping (Result<String, Error>) -> Void ) {
        Task {
            guard let data = try await photoItem.loadTransferable(type: Data.self) else {
                print("upload failed")
                return
            }
            //Setting metadata and path for file
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            let path = "\(courseID)/\(UUID().uuidString).jpeg"
            
            //Uploading
            storage.child(path).putData(data, metadata: metadata) { _, error in
                if let error = error {
                    completionBlock(.failure(error))
                    return
                }
                
                //If success then retrieve URL for data
                self.storage.child(path).downloadURL { url, error in
                    if let error = error {
                        completionBlock(.failure(error))
                        return
                    }
                    if let urlString = url?.absoluteString {
                        completionBlock(.success(urlString))
                    } else {
                        // Handle unexpected case where neither URL nor error is present
                        completionBlock(.failure(NSError(domain: "StorageDataSource", code: 404, userInfo: [NSLocalizedDescriptionKey: "URL not found"])))
                    }
                }
            }
        }
    }
    
    func uploadVideo(courseID: String, photoItem: PhotosPickerItem, completionBlock: @escaping (Result<String, Error>) -> Void ) {
        Task {
            guard let data = try await photoItem.loadTransferable(type: Data.self) else {
                print("upload failed")
                return
            }
            //Setting metadata and path for file
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            let path = "\(courseID)/\(UUID().uuidString).jpeg"
            
            //Uploading
            storage.child(path).putData(data, metadata: metadata) { _, error in
                if let error = error {
                    completionBlock(.failure(error))
                    return
                }
                
                //If success then retrieve URL for data
                self.storage.child(path).downloadURL { url, error in
                    if let error = error {
                        completionBlock(.failure(error))
                        return
                    }
                    if let urlString = url?.absoluteString {
                        completionBlock(.success(urlString))
                    } else {
                        // Handle unexpected case where neither URL nor error is present
                        completionBlock(.failure(NSError(domain: "StorageDataSource", code: 404, userInfo: [NSLocalizedDescriptionKey: "URL not found"])))
                    }
                }
            }
        }
    }
}
