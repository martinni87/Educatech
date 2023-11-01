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
    
    //    func getUserByID(userID: String, completionBlock: @escaping (Result<UserAppModel, Error>) -> Void ){
    //
    //        self.database.collection(self.collection).whereField("id", isEqualTo: userID)
    //            .addSnapshotListener { snapshot, error in
    //                if let error = error {
    //                    completionBlock(.failure(error)) // To return Error case
    //                    return
    //                }
    //                guard let documents = snapshot?.documents.compactMap({ $0 }) else {
    //                    completionBlock(.failure(AppErrors.badID)) // If there's no error, but not id found
    //                    return
    //                }
    //                let list = documents.map { try? $0.data(as: UserAuthModel.self) }
    //                    .compactMap { $0 } // To avoid nil values.
    //                completionBlock(.success(list[0])) // To return User array with data
    //            }
    //    }
    
    func createNewUser(id: String, email: String, nickname: String, completionBlock: @escaping (Result<UserAppModel, Error>) -> Void ) {
        
        self.checkUserNickname(nickname: nickname) { result in
            switch result {
            case .success(let quantity):
                if quantity != false {
                    completionBlock(.failure(AppErrors.nicknameExists))
                    return
                }
                else {
                    let newDocument = self.database.collection(self.collection).document(id)
                    
                    //Setting new document with the data given by the user
                    //We set only id, email and nickname to avoid overriding subscriptions if already exists
                    newDocument.setData( ["id": id,
                                          "email": email,
                                          "nickname": nickname
                                         ]) { error in
                        if let error = error {
                            completionBlock(.failure(error))
                            return
                        }
                        let user = UserAppModel(id: id,
                                                email: email,
                                                nickname: nickname,
                                                subscriptions: [])
                        completionBlock(.success(user))
                    }
                }
            case .failure(let error):
                completionBlock(.failure(error))
            }
        }
    }
    
    func checkUserNickname(nickname: String, completionBlock: @escaping (Result<Bool, Error>) -> Void) {
        self.database.collection(self.collection).whereField("nickname", isEqualTo: nickname)
            .getDocuments { snapshot, error in
                if let error = error {
                    completionBlock(.failure(error))
                    return
                }
                if let documents = snapshot?.documents {
                    completionBlock(.success(documents.isEmpty))
                    return
                }
                return
            }
    }
}
