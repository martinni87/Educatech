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
    private let storageError = NSError(domain: "Storage error", code: 500, userInfo: [NSLocalizedDescriptionKey: "Something went wrong performing the current task. Please contact the admin"])
    
    func deleteStorageByURL(course: CourseModel, urlStringList: [String], collection: CollectionsViewModel) {
        // Start loop for urlString array
        urlStringList.enumerated().forEach { i, urlString in
            //Transform string to url and get fileName without extension
            let urlVideosToDelete = URL(string: urlString)!
            let lastPathComponent = urlVideosToDelete.lastPathComponent
            let fileName = (lastPathComponent as NSString).deletingPathExtension
            
            //Set path, and access
            let path = "courses/\(course.id!)/videos/\(fileName).mp4"
            print(path)
            let reference = storage.child(path)
            
            //Proceed to delete
            reference.delete { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                else if i == urlStringList.count - 1 {
                    collection.editCourseData(changeTo: course)
                    print("Delete for all courses done")
                    return
                }
            }
        }
    }
    
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
