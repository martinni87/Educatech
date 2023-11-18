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
}

////Si funciona
//final class StorageManager {
//
//    static let shared = StorageManager()
//    private init() {}
//
//    private let storage = Storage.storage().reference()
//
//    func uploadPicture(courseID: String, data: Data) async throws -> (path: String, name: String) {
//        let meta = StorageMetadata()
//        meta.contentType = "image/jpeg"
//
//        let path = "\(courseID)/\(UUID().uuidString).jpeg"
//        let returnedMetadata = try await storage.child(path).putDataAsync(data, metadata: meta)
//
//        guard let returnedPath = returnedMetadata.path, let returnedName = returnedMetadata.name else {
//            throw URLError(.badServerResponse)
//        }
//
//        return (returnedPath, returnedName)
//    }
//}
//










//No funciona
//    private let storage = Storage.storage().reference()
//
//    func uploadImage(courseID: String, data: Data, completionBlock: @escaping (Result<String, Error>) -> Void) {
//        let meta = StorageMetadata()
//        meta.contentType = "image/jpeg"
//
//        let path = "\(courseID)_\(UUID().uuidString).jpeg"
//
//        storage.child(path).putData(data, metadata: meta) { storageMeta, error in
//            if let error = error {
//                completionBlock(.failure(error))
//                return
//            }
//            let path = storageMeta?.path ?? "No path"
//            completionBlock(.success(path))
//        }
//    }
//}

//    private let storageRef = Storage.storage().reference(forURL: "gs://educatech-ecab0.appspot.com/courses")
//
//    func uploadImage(courseID: String, imagePath: String, completionBlock: @escaping (Result<String, Error>) -> Void) {
//        // Create course folder and reference for new file
//        let newCourseRef = storageRef.child("\(courseID)")
////        let newFileRef = newCourseRef.child("\(courseID)_pic.jpg")
//        let fileToLoad = URL(string: imagePath)!
//        // Upload method
//        newCourseRef.putFile(from: fileToLoad) { _, error in
//            if let error = error {
//                completionBlock(.failure(error))
//                return
//            }
//        }
//    }
//}
