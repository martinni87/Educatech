////
////  StorageRepository.swift
////  Educatech
////
////  Created by Martín Antonio Córdoba Getar on 1/10/23.
////
//
//import SwiftUI
//import PhotosUI
//import Firebase
//import FirebaseStorage
//
//final class StorageRepository {
//    
//    private let storageDataSource: StorageManager
//    
//    init(storageDataSource: StorageManager = StorageManager()) {
//        self.storageDataSource = storageDataSource
//    }
//    
//    func uploadPicture(courseID: String, photoItem: PhotosPickerItem, completionBlock: @escaping (Result<String, Error>) -> Void ) {
//        Task {
//            guard let data = try await photoItem.loadTransferable(type: Data.self) else {
//                print("upload failed")
//                return
//            }
//            storageDataSource.uploadPicture(courseID: courseID, data: data, completionBlock: completionBlock)
//        }
//    }
//}
////
////    private let storageDataSource: StorageDataSource
////    
////    init(storageDataSource: StorageDataSource = StorageDataSource()) {
////        self.storageDataSource = storageDataSource
////    }
////  
////    func uploadPicture(data: Data) async throws -> (path: String, name: String){
////        try await self.storageDataSource.uploadPicture(data: data)
////    }
//////    func uploadImage(courseID: String, data: Data, completionBlock: @escaping (Result<String, Error>) -> Void) {
//////        storageDataSource.uploadImage(courseID: courseID, data: data, completionBlock: completionBlock)
//////    }
////}
