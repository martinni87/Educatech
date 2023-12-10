//
//  AuthDataSource.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

/// A class responsible for managing authentication-related data operations, including user registration, login, and user data manipulation.
final class AuthDataSource {
    
    private let database = Firestore.firestore()
    private let usersCollection = "users"
    
    // MARK: - Registration form validations
    
    /// Validates the email format and availability for registration.
    ///
    /// - Parameters:
    ///   - formInputs: The registration form inputs.
    ///   - completionBlock: A completion block to handle the validation result.
    
    func emailValidations(_ formInputs: RegistrationFormInputs, completionBlock: @escaping (Bool, String?) -> Void) {
        //Email check
        formInputs.email.emailFormatIsValid { isValid, errorMsg in
            if !isValid {
                completionBlock(false, errorMsg)
                return
            }
            self.emailIsAvailable(email: formInputs.email) { isAvailable, error in
                if !isAvailable {
                    completionBlock(false, error)
                    return
                }
                completionBlock(true, nil)
            }
        }
    }
    
    /// Validates the username format and availability for registration.
    ///
    /// - Parameters:
    ///   - formInputs: The registration form inputs.
    ///   - completionBlock: A completion block to handle the validation result.
    func usernameValidations(_ formInputs: RegistrationFormInputs, completionBlock: @escaping (Bool, String?) -> Void) {
        //Username check
        formInputs.username.fieldIsNotEmpty { isNotEmpty, errorMsg in
            if !isNotEmpty {
                completionBlock(false, errorMsg)
                return
            }
            self.usernameIsAvailable(username: formInputs.username) { isAvailable, errorMsg in
                if !isAvailable {
                    completionBlock(false, errorMsg)
                    return
                }
                completionBlock(true, nil)
            }
        }
    }
    
    /// Validates the password format for registration.
    ///
    /// - Parameters:
    ///   - formInputs: The registration form inputs.
    ///   - completionBlock: A completion block to handle the validation result.
    func passwordValidations(_ formInputs: RegistrationFormInputs, completionBlock: @escaping (Bool, String?) -> Void ) {
        //Password check
        formInputs.password.passwordFormatIsValid(email: formInputs.email) { isValid, errorMsg in
            if !isValid {
                completionBlock(false, errorMsg)
                return
            }
            completionBlock(true, nil)
        }
    }
    
    /// Validates the repeated password for registration.
    ///
    /// - Parameters:
    ///   - formInputs: The registration form inputs.
    ///   - completionBlock: A completion block to handle the validation result.
    func repeatedPasswordValidations(_ formInputs: RegistrationFormInputs, completionBlock: @escaping (Bool, String?) -> Void ) {
        //Password check
        formInputs.repeatPassword.repeatedPasswordIsValid(password: formInputs.password) { isValid, errorMsg in
            if !isValid {
                completionBlock(false, errorMsg)
                return
            }
            completionBlock(true, nil)
        }
    }
    
    // MARK: - Sign up, sign in, logout, and user auth
        
    /// Registers a new user with email and password.
    ///
    /// - Parameters:
    ///   - formInputs: The registration form inputs.
    ///   - completionBlock: A completion block to handle the registration result.
    func signUpEmail(formInputs: RegistrationFormInputs, completionBlock: @escaping (Result<UserDataModel, Error>) -> Void ) {
        //Check if username is available. If available, new user not created
        let email = formInputs.email.lowercased()
        let username = formInputs.username.lowercased()
        self.usernameIsAvailable(username: username) { available, _ in
            if available {
                Auth.auth().createUser(withEmail: email, password: formInputs.password) { authDataResult, error in
                    if let error = error {
                        completionBlock(.failure(error))
                        return
                    }
                    let email = authDataResult?.user.email ?? "No email"
                    let id = authDataResult?.user.uid ?? "0"
                    let newUser = UserDataModel(id: id, email: email, username: username, categories: formInputs.categories)
                    self.createNewUser(user: newUser) { result in
                        switch result {
                        case .success(let user):
                            completionBlock(.success(UserDataModel(id: user.id,
                                                                   email: user.email,
                                                                   username: user.username,
                                                                   isEditor: user.isEditor,
                                                                   categories: user.categories,
                                                                   contentCreated: user.contentCreated,
                                                                   subscriptions: user.subscriptions)))
                        case .failure(let error):
                            completionBlock(.failure(error))
                        }
                    }
                    completionBlock(.success(UserDataModel(id: id, email: email, username: formInputs.username)))
                }
            }
        }
    }
    
    /// Signs in a user with email and password.
    ///
    /// - Parameters:
    ///   - formInputs: The login form inputs.
    ///   - completionBlock: A completion block to handle the login result.
    func signInEmail(formInputs: LoginFormInputs, completionBlock: @escaping (Result<UserDataModel,Error>) -> Void ) {
        Auth.auth().signIn(withEmail: formInputs.email, password: formInputs.password) { authDataResult, error in
            if let error = error {
                completionBlock(.failure(error))
                return
            }
            else if let id = authDataResult?.user.uid {
                self.getUserByID(userID: id) { result in
                    switch result {
                    case .success(let user):
                        completionBlock(.success(UserDataModel(id: user.id,
                                                               email: user.email,
                                                               username: user.username,
                                                               isEditor: user.isEditor,
                                                               categories: user.categories,
                                                               contentCreated: user.contentCreated,
                                                               subscriptions: user.subscriptions)))
                    case .failure(let error):
                        completionBlock(.failure(error))
                    }
                }
                return
            }
        }
    }
    
    /// Signs out the current user.
    ///
    /// - Throws: An error if signing out fails.
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    /// Retrieves the current authenticated user's information.
    ///
    /// - Returns: The user authentication model or nil if no user is authenticated.
    func getCurrentUserAuth() -> UserAuthModel? {
        if let id = Auth.auth().currentUser?.uid, let email = Auth.auth().currentUser?.email {
            return UserAuthModel(id: id, email: email)
        }
        else {
            return nil
        }
    }
    
    // MARK: User Data from users collection
    /// Retrieves the current user's data.
    ///
    /// - Parameter completionBlock: A completion block to handle the user data retrieval result.
    func getCurrentUserData(completionBlock: @escaping (Result<UserDataModel, Error>) -> Void) {
        if let id = Auth.auth().currentUser?.uid {
            self.getUserByID(userID: id) { result in
                switch result {
                case .success(let user):
                    completionBlock(.success(UserDataModel(id: user.id,
                                                           email: user.email,
                                                           username: user.username,
                                                           isEditor: user.isEditor,
                                                           categories: user.categories,
                                                           contentCreated: user.contentCreated,
                                                           subscriptions: user.subscriptions)))
                case .failure(let error):
                    completionBlock(.failure(error))
                }
            }
        }
    }
    
    /// Creates a new user document in the Firestore collection.
    ///
    /// - Parameters:
    ///   - user: The user data model representing the new user.
    ///   - completionBlock: A completion block to handle the user creation result.
    func createNewUser(user: UserDataModel, completionBlock: @escaping (Result<UserDataModel, Error>) -> Void ) {
        //Creating document in collection with given id
        let newDocument = self.database.collection(self.usersCollection).document(user.id ?? "0")
        
        //Setting new document with the data given by the user
        newDocument.setData( ["id": user.id ?? "0",
                              "email": user.email,
                              "username": user.username,
                              "isEditor": user.isEditor,
                              "categories": user.categories,
                              "contentCreated": user.contentCreated,
                              "subscriptions": user.subscriptions
                             ]) { error in
            if let error = error {
                completionBlock(.failure(error))
                return
            }
            let user = UserDataModel(id: user.id,
                                     email: user.email,
                                     username: user.username,
                                     isEditor: user.isEditor,
                                     categories: user.categories,
                                     contentCreated: user.contentCreated,
                                     subscriptions: user.subscriptions)
            completionBlock(.success(user))
        }
    }
    
    /// Edits the user data in the Firestore collection.
    ///
    /// - Parameters:
    ///   - userData: The updated user data model.
    ///   - completionBlock: A completion block to handle the user data editing result.
    func editUserData(changeTo userData: UserDataModel, completionBlock: @escaping (Result<UserDataModel, Error>) -> Void) {
        let userDocument = self.database.collection(self.usersCollection).document(userData.id ?? "0")
        userDocument.setData( ["id": userData.id ?? "0",
                               "email": userData.email,
                               "username": userData.username,
                               "isEditor": userData.isEditor,
                               "categories": userData.categories,
                               "contentCreated": userData.contentCreated,
                               "subscriptions": userData.subscriptions
                              ]) { error in
            if let error = error {
                completionBlock(.failure(error))
                return
            }
            let newUserData = UserDataModel(id: userData.id,
                                            email: userData.email,
                                            username: userData.username,
                                            isEditor: userData.isEditor,
                                            categories: userData.categories, //If categories were modified, then it reflects here
                                            contentCreated: userData.contentCreated, //If contentCreated were modified, then it reflects here
                                            subscriptions: userData.subscriptions) //If contentCreated were modified, then it reflects here
            completionBlock(.success(newUserData))
        }
    }
    
    // MARK: Private check methods
    /// Checks if an email is available for registration.
    ///
    /// - Parameters:
    ///   - email: The email to check.
    ///   - completionBlock: A completion block to handle the availability check result.
    private func emailIsAvailable(email: String, completionBlock: @escaping (Bool, String?) -> Void ){
        let email = email.lowercased()
        let documents = self.database.collection(self.usersCollection).whereField("email", isEqualTo: email)
        documents.getDocuments { query, error in
            if let _ = error {
                completionBlock(false, "Something went wrong. Try again in a few minuts and contact the Admin if the problem persists.")
                return
            }
            let numberOfDocuments = query?.documents.count ?? 0
            if numberOfDocuments > 0 {
                completionBlock(false, "Email is not available. Try with another email address, or login with the current account.")
                return
            }
            completionBlock(true, nil)
        }
    }
    
    /// Checks if a username is available for registration.
    ///
    /// - Parameters:
    ///   - username: The username to check.
    ///   - completionBlock: A completion block to handle the availability check result.
    private func usernameIsAvailable(username: String, completionBlock: @escaping (Bool, String?) -> Void ){
        let username = username.lowercased()
        let documents = self.database.collection(self.usersCollection).whereField("username", isEqualTo: username)
        documents.getDocuments { query, error in
            if let _ = error {
                completionBlock(false, "Something went wrong. Try again in a few minuts and contact the Admin if the problem persists.")
                return
            }
            let numberOfDocuments = query?.documents.count ?? 0
            if numberOfDocuments > 0 {
                completionBlock(false, "Username is not available. Please try other name you'd like.")
                return
            }
            completionBlock(true, nil)
        }
    }
    
    /// Retrieves a user by ID from the Firestore collection.
    ///
    /// - Parameters:
    ///   - userID: The ID of the user to retrieve.
    ///   - completionBlock: A completion block to handle the user retrieval result.
    private func getUserByID(userID: String, completionBlock: @escaping (Result<UserDataModel, Error>) -> Void ){
        let userDocument = self.database.collection(self.usersCollection).document(userID)
        userDocument.getDocument(source: .server) { document, error in
            if let error = error {
                completionBlock(.failure(error))
                return
            }
            if let document = document, document.exists {
                let id = document.get("id") as! String
                let email = document.get("email") as! String
                let username = document.get("username") as! String
                let isEditor = document.get("isEditor") as! Bool
                let categories = document.get("categories") as! [String]
                let contentCreated = document.get("contentCreated") as! [String]
                let subscriptions = document.get("subscriptions") as! [String]
                completionBlock(.success(UserDataModel(id: id,
                                                       email: email,
                                                       username: username,
                                                       isEditor: isEditor,
                                                       categories: categories,
                                                       contentCreated: contentCreated,
                                                       subscriptions: subscriptions)))
                return
            }
        }
    }
}
