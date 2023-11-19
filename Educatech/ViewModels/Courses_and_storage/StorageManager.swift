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
    private let uploadError = NSError(domain: "Upload error", code: 500, userInfo: [NSLocalizedDescriptionKey: "Something went wrong uploading data."])
    
    func uploadPicture(courseID: String, photoItem: PhotosPickerItem, completionBlock: @escaping (Result<String, Error>) -> Void ) {
        //Setting metadata and path for file
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        let path = "courses/\(courseID)/img/\(UUID().uuidString).jpeg"
        
        //Setting photoItem as Data type
        photoItem.loadTransferable(type: Data.self) { result in
            switch result {
            case .failure(let error):
                completionBlock(.failure(error))
            case .success(let data):
                //Uploading
                self.storage.child(path).putData(data!, metadata: metadata) { _, error in
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
//        Task {
//            guard let data = try await photoItem.loadTransferable(type: Data.self) else {
//                completionBlock(.failure(self.uploadError))
//                return
//            }
//            //Setting metadata and path for file
//            let metadata = StorageMetadata()
//            metadata.contentType = "image/jpeg"
//            let path = "\(courseID)/\(UUID().uuidString).jpeg"
//            
//            //Uploading
//            storage.child(path).putData(data, metadata: metadata) { _, error in
//                if let error = error {
//                    completionBlock(.failure(error))
//                    return
//                }
//                
//                //If success then retrieve URL for data
//                self.storage.child(path).downloadURL { url, error in
//                    if let error = error {
//                        completionBlock(.failure(error))
//                        return
//                    }
//                    if let urlString = url?.absoluteString {
//                        completionBlock(.success(urlString))
//                    } else {
//                        // Handle unexpected case where neither URL nor error is present
//                        completionBlock(.failure(NSError(domain: "StorageDataSource", code: 404, userInfo: [NSLocalizedDescriptionKey: "URL not found"])))
//                    }
//                }
//            }
//        }
//    }
    
    func uploadVideo(courseID: String, selectedVideo: PhotosPickerItem, completionBlock: @escaping (Result<StorageMetadata, Error>) -> Void ) {
        //Setting metadata and path for file
        let metadata = StorageMetadata()
        metadata.contentType = "video/.mp4"
        let path = "courses/\(courseID)/videos/\(UUID().uuidString).mp4"
        
        selectedVideo.loadTransferable(type: Data.self) { result in
            switch result {
            case .failure(let error):
                completionBlock(.failure(error))
                return
            case .success(let data):
                //Uploading
                self.storage.child(path).putData(data!, metadata: metadata) { result in
                    switch result {
                    case .failure(let error):
                        completionBlock(.failure(error))
                    case .success(let storageMetadata):
                        completionBlock(.success(storageMetadata))
                    }
                }
            }
        }
    }
//                self.storage.child(path).putData(data!, metadata: metadata) { result in
//                    switch result {
//                    case .success(_):
//                        completionBlock(.success(count + 1))
//                        return
//                    case .failure(let error):
//                        completionBlock(.failure(error))
//                    }
//                }
//            }
//        }
//    }
//            Task {
//                guard let data = try await selectedVideo.loadTransferable(type: Data.self) else {
//                    completionBlock(self.uploadError)
//                    return
//                }
//                //Setting metadata and path for file
//                //let fileExtension = URL(fileURLWithPath: selectedVideo.itemIdentifier ?? "").pathExtension.lowercased()
//                let metadata = StorageMetadata()
//                
//                metadata.contentType = "video/.mp4"
//                
//                let path = "courses/\(courseID)/\(UUID().uuidString).mp4"
//                
//                //Uploading
//                storage.child(path).putData(data, metadata: metadata) { _, error in
//                    if let error = error {
//                        completionBlock(error)
//                        return
//                    }
//                }
//            }
//        }
//    }
    
    func retrieveVideosList(courseID: String, completionBlock: @escaping (Result<[String], Error>) -> Void ) {
        //Retrieve URL of videos
        let path = "courses/\(courseID)/videos"
        storage.child(path).listAll { list, error in
            if let error = error {
                completionBlock(.failure(error))
                return
            }
            var downloadURLs: [String] = []
            list?.items.forEach { item in
                item.downloadURL { url, error in
                    if let error = error {
                        completionBlock(.failure(error))
                        return
                    }
                    if let urlString = url?.absoluteString {
                        downloadURLs.append(urlString)
                    }
                    if downloadURLs.count == list?.items.count {
                        completionBlock(.success(downloadURLs))
                    }
                }
            }
        }
    }
    
}
