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
import GoogleSignIn
import GoogleSignInSwift


final class AuthDataSource {
    
    private let database = Firestore.firestore()
    private let usersCollection = "users"
    
    //MARK: Registration form validations
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
    
    //MARK: Sing up, sign in, logout and user auth
    
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
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func getCurrentUserAuth() -> UserAuthModel? {
        if let id = Auth.auth().currentUser?.uid, let email = Auth.auth().currentUser?.email {
            return UserAuthModel(id: id, email: email)
        }
        else {
            return nil
        }
    }
    
    //MARK: User Data from users collection
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
    
    func addNewSubscription(newCourse: CourseModel, userData: UserDataModel, completionBlock: @escaping (Result<UserDataModel, Error>) -> Void) {
        //Getting document for current user
        let document = self.database.collection(self.usersCollection).document(userData.id ?? "0")
        var newSubscriptions = userData.subscriptions
        newSubscriptions.append(newCourse.id ?? "0")
        let newUserData = UserDataModel(id: userData.id,
                                        email: userData.email,
                                        username: userData.username,
                                        isEditor: userData.isEditor,
                                        categories: userData.categories,
                                        contentCreated: userData.contentCreated,
                                        subscriptions: newSubscriptions)
        //Setting new data
        document.setData( ["id": newUserData.id ?? "0",
                           "email": newUserData.email,
                           "username": newUserData.username,
                           "isEditor": newUserData.isEditor,
                           "categories": newUserData.categories,
                           "contentCreated": newUserData.contentCreated,
                           "subscriptions": newUserData.subscriptions
                          ]) { error in
            if let error = error {
                completionBlock(.failure(error))
                return
            }
            completionBlock(.success(newUserData))
        }
    }
    
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
    
    //MARK: Private check methods
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
//
//    private let facebookAuth = FacebookAuth()
//    private let googleAuth = GoogleAuth()
//
//    func signUpEmail(email: String, password: String, completionBlock: @escaping (Result<UserAuthModel,Error>) -> Void ) {
//        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
//            if let error = error {
//                completionBlock(.failure(error))
//                return
//            }
//            if let email = authDataResult?.user.email, let id = authDataResult?.user.uid {
//                completionBlock(.success(UserAuthModel(id: id, email: email)))
//                return
//            }
//            //In case none of the above happens, throw auth error
//            completionBlock(.failure(AppErrors.authError))
//        }
//    }
//
//    func signInEmail(email: String, password: String, completionBlock: @escaping (Result<UserAuthModel,Error>) -> Void ) {
//        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
//            if let error = error {
//                completionBlock(.failure(error))
//                return
//            }
//            if let email = authDataResult?.user.email, let id = authDataResult?.user.uid {
//                completionBlock(.success(UserAuthModel(id: id, email: email)))
//                return
//            }
//            //In case none of the above happens, throw auth error
//            completionBlock(.failure(AppErrors.authError))
//        }
//    }
//
//    func facebookLogin(completionBlock: @escaping (Result<UserAuthModel, Error>) -> Void ) {
//        facebookAuth.facebookLogin { result in
//            switch result {
//            case .success(let accessToken):
//                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
//                Auth.auth().signIn(with: credential) { authDataResult, error in
//                    if let error = error {
//                        completionBlock(.failure(error))
//                        return
//                    }
//                    if let email = authDataResult?.user.email, let id = authDataResult?.user.uid {
//                        completionBlock(.success(UserAuthModel(id: id, email: email)))
//                        return
//                    }
//                    //In case none of the above happens, throw auth error
//                    completionBlock(.failure(AppErrors.authError))
//                }
//            case .failure(let error):
//                print("Error signing in with facebook at Data Source. Error: \(error.localizedDescription)")
//                completionBlock(.failure(error))
//            }
//        }
//    }
//
//    func googleLogin(completionBlock: @escaping (Result<UserAuthModel, Error>) -> Void) {
//        googleAuth.googleLogin { result in
//            switch result {
//            case .success(let googleUser):
//                let idToken = googleUser.idToken?.tokenString ?? "No token"
//                let accessToken = googleUser.accessToken.tokenString
//                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
//                Auth.auth().signIn(with: credential) { authDataResult, error in
//                    if let error = error {
//                        completionBlock(.failure(error))
//                        return
//                    }
//                    if let email = authDataResult?.user.email, let id = authDataResult?.user.uid {
//                        completionBlock(.success(UserAuthModel(id: id, email: email)))
//                        return
//                    }
//                    //In case none of the above happens, throw auth error
//                    completionBlock(.failure(AppErrors.authError))
//                }
//            case .failure(let failure):
//                completionBlock(.failure(failure))
//            }
//        }
//    }
//
//    func getCurrentUser() -> UserAuthModel? {
//        if let email = Auth.auth().currentUser?.email, let id = Auth.auth().currentUser?.uid {
//            return UserAuthModel(id: id, email: email)
//        }
//        else {
//            return nil
//        }
//    }
//
//    func signOut() throws {
//        try Auth.auth().signOut()
//    }
//
//    func currentProvider() -> [LinkedAccounts] {
//        guard let currentUser = Auth.auth().currentUser else {
//            return []
//        }
//        //Map provider data to build a LinkAccounts array with current providers registered in Firebase
//        let linkedAccounts = currentUser.providerData.map { userInfo in
//            LinkedAccounts(rawValue: userInfo.providerID)
//        }.compactMap { $0 } //Delete all nil values in array.
//        return linkedAccounts
//    }
//
//    func getLastProviderCredential() -> AuthCredential? {
//        guard let providerId = currentProvider().last else {
//            return nil
//        }
//        switch providerId {
//        case .facebook:
//            guard let accessToken = facebookAuth.getAccessToken() else {
//                return nil
//            }
//            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
//            return credential
//        case .google:
//            guard let currentUser = googleAuth.getCurrentUser() else {
//                return nil
//            }
//            let idToken = currentUser.idToken?.tokenString ?? "No id token"
//            let accessToken = currentUser.accessToken.tokenString
//            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
//            return credential
//        case .emailAndPassword, .apple, .unknown:
//            return nil
//        }
//    }
//
//    func linkEmailAndPassword(email: String, password: String, completionBlock: @escaping (Bool) -> Void) {
//        guard let credential = getLastProviderCredential() else {
//            print("No credential")
//            completionBlock(false)
//            return
//        }
//
//        Auth.auth().currentUser?.reauthenticate(with: credential, completion: { authDataResult, error in
//            if let error = error {
//                print("Error reauthenticating user: \(error.localizedDescription)")
//                completionBlock(false)
//                return
//            }
//            let emailAndPassword = EmailAuthProvider.credential(withEmail: email, password: password)
//            Auth.auth().currentUser?.link(with: emailAndPassword, completion: { authDataResult, error in
//                if let error = error {
//                    print(error.localizedDescription)
//                    completionBlock(false)
//                    return
//                }
//                let email = authDataResult?.user.email ?? "No email"
//                print(email)
//                completionBlock(true)
//            })
//        })
//
//    }
//
//    func linkFacebook(completionBlock: @escaping (Bool) -> Void) {
//        facebookAuth.facebookLogin { result in
//            switch result {
//            case .success(let accessToken):
//                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
//                Auth.auth().currentUser?.link(with: credential) { authDataResult, error in
//                    if let error = error {
//                        print(error.localizedDescription)
//                        completionBlock(false)
//                        return
//                    }
//                    let email = authDataResult?.user.email ?? "No email"
//                    print(email)
//                    completionBlock(true)
//                }
//            case .failure(let error):
//                print("Error linking user with Facebook. Error: \(error.localizedDescription)")
//                completionBlock(false)
//            }
//        }
//    }
//
//    func linkGoogle(completionBlock: @escaping (Bool) -> Void) {
//        googleAuth.googleLogin { result in
//            switch result {
//            case .success(let googleUser):
//                let idToken = googleUser.idToken?.tokenString ?? "No token"
//                let accessToken = googleUser.accessToken.tokenString
//                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
//                Auth.auth().currentUser?.link(with: credential) { authDataResult, error in
//                    if let error = error {
//                        print(error.localizedDescription)
//                        completionBlock(false)
//                        return
//                    }
//                    let email = authDataResult?.user.email ?? "No email"
//                    print(email)
//                    completionBlock(true)
//                }
//            case .failure(let error):
//                print("Error linking user with Google. Error: \(error.localizedDescription)")
//                completionBlock(false)
//            }
//        }
//    }
//}
