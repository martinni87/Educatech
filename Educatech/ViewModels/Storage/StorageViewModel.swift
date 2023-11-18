////
////  StorageViewModel.swift
////  Educatech
////
////  Created by Martín Antonio Córdoba Getar on 1/10/23.
////
//
//import SwiftUI
//import Firebase
//import FirebaseStorage
//import PhotosUI
//
//final class StorageViewModel: ObservableObject {
//    
//    @Published var urlString: String = ""
//    @Published var errorMsg: String?
//    
//    private let storageRepository: StorageRepository
//    
//    init(storageRepository: StorageRepository = StorageRepository()) {
//        self.storageRepository = storageRepository
//    }
//    
//    func uploadPicture(courseID: String, photoItem: PhotosPickerItem) {
//        Task {
//            guard let data = try await photoItem.loadTransferable(type: Data.self) else {
//                print("upload failed")
//                return
//            }
//            storageRepository.uploadPicture(courseID: courseID, data: data) { [weak self] result in
//                switch result {
//                case .success(let url):
//                    self?.urlString = url
//                case .failure(let error):
//                    self?.errorMsg = error.localizedDescription
//                }
//            }
//        }
//    }
//}
//    
//    //Si funciona
//    @Published var message: String?
//    
//    func uploadPicture(courseID: String, item: PhotosPickerItem) {
//        Task {
//            guard let data = try await item.loadTransferable(type: Data.self) else { return }
//            let (path, name) = try await StorageManager.shared.uploadPicture(courseID: courseID, data: data)
//            print("Success")
//            print("path: \(path)")
//            print("name: \(name)")
//        }
//    }
//    
//    func getPictureURL() -> String {
//        return ""
//    }
    
    
    
    
    
    
    
    //No funciona
//    private let storageRepository: StorageRepository
//    
//    init(storageRepository: StorageRepository = StorageRepository()) {
//        self.storageRepository = storageRepository
//    }
//    
//    func uploadImage(courseID: String, picture: PhotosPickerItem) {
//        Task {
//            guard let data = try await picture.loadTransferable(type: Data.self) else { return self.message = "Failed to load" }
//            storageRepository.uploadImage(courseID: courseID, data: data) { [weak self] result in
//                switch result {
//                case .success(_):
//                    self?.message = "Upload was successfully"
//                case .failure(let error):
//                    self?.message = error.localizedDescription
//                }
//            }
//        }
//    }
