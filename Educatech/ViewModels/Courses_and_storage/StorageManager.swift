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

/// A class responsible for managing storage-related operations, including uploading and deleting files.
final class StorageManager {
    
    private let storage = Storage.storage().reference()
    private let storageError = NSError(domain: "Storage error", code: 500, userInfo: [NSLocalizedDescriptionKey: "Something went wrong performing the current task. Please contact the admin"])
    
    /// Deletes videos in storage based on the provided URL strings and updates the course data.
    ///
    /// - Parameters:
    ///   - course: The course model.
    ///   - urlStringList: The list of video URL strings to delete.
    ///   - collection: The collections view model.
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
    
    /// Uploads a picture for a given course ID.
    ///
    /// - Parameters:
    ///   - courseID: The ID of the course.
    ///   - photoItem: The photo item to upload.
    ///   - completionBlock: A completion block to handle the upload result.
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
    
    /// Uploads a video for a given course ID.
    ///
    /// - Parameters:
    ///   - courseID: The ID of the course.
    ///   - selectedVideo: The video item to upload.
    ///   - completionBlock: A completion block to handle the upload result.
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
    
    /// Retrieves a list of video URLs for a given course ID.
    ///
    /// - Parameters:
    ///   - courseID: The ID of the course.
    ///   - completionBlock: A completion block to handle the retrieval result.
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
