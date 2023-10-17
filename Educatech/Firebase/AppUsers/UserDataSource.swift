//
//  UserDataSource.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 12/10/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class UserDataSource {
    
    private let database = Firestore.firestore()
    private let collection = "users"
    
    func getUserByID(userID: String, completionBlock: @escaping (Result<User, Error>) -> Void ){
        
        self.database.collection(self.collection).whereField("id", isEqualTo: userID)
            .addSnapshotListener { query, error in
                if let error = error {
                    completionBlock(.failure(error)) // To return Error case
                    return
                }
                guard let documents = query?.documents.compactMap({ $0 }) else {
                    completionBlock(.failure(AppErrors.badID)) // If there's no error, but not id found
                    return
                }
                let list = documents.map { try? $0.data(as: User.self) }
                    .compactMap { $0 } // To avoid nil values.
                completionBlock(.success(list[0])) // To return User array with data
            }
    }
}
