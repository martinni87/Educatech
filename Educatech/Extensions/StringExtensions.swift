//
//  StringExtensions.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 26/9/23.
//
import Foundation

//enum AppError: String, Error {
//    case mandatoryField = "All fields are mandatory. Please, try again."
//    case emailBadFormat = "Email is badly formatted. Please, try again."
//    case passwordBadFormat1 = "Password must be between 6 and 12 characters."
//    case passwordBadFormat2 = "Password must contain at least 1 letter."
//    case passwordBadFormat3 = "Password must contain at least 1 number."
//    case passwordBadFormat4 = "Password must contain at least 1 of the following symbols: '* + - _ . ? !'"
//    case passwordBadFormat5 = "Password must contain at least 1 lowercase and 1 uppercase letter."
//    case passwordBadFormat6 = "Password cannot be part of the email."
//    case passwordBadFormat7 = "Password is too common. Try something different to protect better your account."
//    case passwordBadFormat8 = "Passwords don't match."
//}

extension String {
    
    //    func localized() -> String {
    //        let translated = String(localized: LocalizedStringResource(stringLiteral: self))
    //        return translated
    //    }
    
    func fieldIsNotEmpty(completionBlock: @escaping (Bool, String?) -> Void) {
        if self.isEmpty || self == "" {
            completionBlock(false, "All fields are mandatory. Please, try again.")
            return
        }
        //Last result, everything's ok
        completionBlock(true, nil)
    }
    
    func validateURLString(completionBlock: @escaping (Bool, String?) -> Void ) {
        let urlRegex = #"^(https?|ftp)://[^\s/$.?#]+.*$"# // Regular expression for URL validation
        let urlTest = NSPredicate(format: "SELF MATCHES %@", urlRegex)
        let urlIsValid = urlTest.evaluate(with: self.lowercased())
        
        self.fieldIsNotEmpty { isNotEmpty, errorMsg in
            if !isNotEmpty {
                completionBlock(false, errorMsg)
                return
            }
            if !urlIsValid {
                completionBlock(false, "URL is badly formatted. Please, try again.")
                return
            }
            //Last result, everything's ok
            completionBlock(true, nil)
        }
    }
    
    func emailFormatIsValid(completionBlock: @escaping (Bool, String?) -> Void) {
        /**
         * validateEmail function uses a regular expression pattern that checks for a typical email format.
         * It allows letters, digits, plus signs, underscores, fots and hyphens before "@" symbol
         * It also allows any domain name after the "@" symbol. This pattern aligns with most used email formats
         */
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let emailIsValid = emailTest.evaluate(with: self)
        
        self.fieldIsNotEmpty { isNotEmpty, errorMsg in
            if !isNotEmpty {
                completionBlock(false, errorMsg)
                return
            }
            if !emailIsValid {
                completionBlock(false, "Email is badly formatted. Please, try again.")
                return
            }
            //Last result, everything's ok
            completionBlock(true, nil)
        }
    }
    
    func passwordFormatIsValid(email: String, completionBlock: @escaping (Bool, String?) -> Void) {
        //Check if field is empty
        self.fieldIsNotEmpty { isNotEmpty, errorMsg in
            if !isNotEmpty {
                completionBlock(false, errorMsg)
                return
            }
            
            // Check for minimun and maximun length
            if !(6...12).contains(self.count) {
                completionBlock(false, "Password must be between 6 and 12 characters.")
                return
            }
            
            // Check for at least 1 letter, 1 number, and 1 symbol
            let letterPredicate = NSPredicate(format: "SELF MATCHES %@", ".*[A-Za-z]+.*")
            let numberPredicate = NSPredicate(format: "SELF MATCHES %@", ".*\\d+.*")
            let symbolPredicate = NSPredicate(format: "SELF MATCHES %@", ".*[@*\\-+_\\.?!]+.*")
            
            if !letterPredicate.evaluate(with: self) {
                completionBlock(false, "Password must contain at least 1 letter.")
                return
            }
            
            if !numberPredicate.evaluate(with: self) {
                completionBlock(false, "Password must contain at least 1 number.")
                return
            }
            
            if !symbolPredicate.evaluate(with: self) {
                completionBlock(false, "Password must contain at least 1 of the following symbols: '* + - _ . ? !'")
                return
            }
            
            // Check for at least 1 lowercase and 1 uppercase letter
            let lowercasePredicate = NSPredicate(format: "SELF MATCHES %@", ".*[a-z]+.*")
            let uppercasePredicate = NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*")
            
            if !lowercasePredicate.evaluate(with: self) || !uppercasePredicate.evaluate(with: self) {
                completionBlock(false, "Password must contain at least 1 lowercase and 1 uppercase letter.")
                return
            }
            
            // Check if it's part of the given email
            if email.lowercased().contains(self.lowercased()) {
                completionBlock(false, "Password cannot be part of the email.")
                return
            }
            
            // Check for common weak passwords
            let commonPasswords = ["123456", "12345678", "qwerty", "password", "pass"] //Add more restrictions if needed
            if commonPasswords.contains(self.lowercased()) {
                completionBlock(false, "Password is too common. Try something different to protect better your account.")
                return
            }
            
            //Last result, everything's ok
            completionBlock(true, nil)
        }
    }
    
    func repeatedPasswordIsValid(password: String, completionBlock: @escaping (Bool, String?) -> Void) {
        self.fieldIsNotEmpty { isNotEmpty, errorMsg in
            if !isNotEmpty {
                completionBlock(false, errorMsg)
                return
            }
            if self != password {
                completionBlock(false, "Passwords don't match.")
                return
            }
            //Last result, everything's ok
            completionBlock(true, nil)
        }
    }
}














////
////  StringExtensions.swift
////  Educatech
////
////  Created by Martín Antonio Córdoba Getar on 26/9/23.
////
//import Foundation
//
//extension String {
//
//    func localized() -> String {
//        let translated = String(localized: LocalizedStringResource(stringLiteral: self))
//        return translated
//    }
//
//    func validateURLString() -> (isValid: Bool, errorMsg: String) {
//        let urlRegex = #"^(https?|ftp)://[^\s/$.?#]+.*$"# // Regular expression for URL validation
//        let urlTest = NSPredicate(format: "SELF MATCHES %@", urlRegex)
//        if !urlTest.evaluate(with: self.lowercased()) {
//            return (isValid: false, errorMsg: "URL String badly formatted")
//        }
//        return (isValid: true, errorMsg: "")
//    }
//
//    func validateNotEmptyString() -> (isValid: Bool, errorMsg: String) {
//        if self.isEmpty || self == "" {
//            return (isValid: false, errorMsg: "All fields are mandatory")
//        }
//        return (isValid: true, errorMsg: "")
//    }
//
//    func validateEmail() -> (isValid: Bool, errorMsg: String) {
//        /**
//         * isValidEmail function uses a regular expression pattern that checks for a typical email format.
//         * It allows letters, digits, plus signs, underscores, fots and hyphens before "@" symbol
//         * It also allows any domain name after the "@" symbol. This pattern aligns with most used email formats
//         */
//        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
//        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
//        let emailIsValid = emailTest.evaluate(with: self)
//        //Checking if email is not valid
//        if !emailIsValid {
//            return (isValid: false, errorMsg: "Email is badly formatted. Please, try again.")
//        }
//
//        // If all checks pass, the password is valid
//        return (isValid: true, errorMsg: "")
//    }
//
//    func validatePassword(for email: String, repeated password: String) -> (isValid: Bool, errorMsg: String) {
//        // Check for minimum and maximum length
//        if !(6...12).contains(self.count) {
//            return (isValid: false, errorMsg: "Password must be between 6 and 12 characters.")
//        }
//
//        // Check for at least 1 letter, 1 number, and 1 symbol
//        let letterPredicate = NSPredicate(format: "SELF MATCHES %@", ".*[A-Za-z]+.*")
//        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", ".*\\d+.*")
//        let symbolPredicate = NSPredicate(format: "SELF MATCHES %@", ".*[@*\\-+_\\.?!]+.*")
//
//        if !letterPredicate.evaluate(with: self) {
//            return (isValid: false, errorMsg: "Password must contain at least 1 letter.")
//        }
//
//        if !numberPredicate.evaluate(with: self) {
//            return (isValid: false, errorMsg: "Password must contain at least 1 number.")
//        }
//
//        if !symbolPredicate.evaluate(with: self) {
//            return (isValid: false, errorMsg: "Password must contain at least 1 of the following symbols: \("* + - _ . ? !") ")
//        }
//
//        // Check for at least 1 lowercase and 1 uppercase letter
//        let lowercasePredicate = NSPredicate(format: "SELF MATCHES %@", ".*[a-z]+.*")
//        let uppercasePredicate = NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*")
//
//        if !lowercasePredicate.evaluate(with: self) || !uppercasePredicate.evaluate(with: self) {
//            return (isValid: false, errorMsg: "Password must contain at least 1 lowercase and 1 uppercase letter.")
//        }
//
//        // Check if it's part of the given email
//        if email.lowercased().contains(self.lowercased()) {
//            return (isValid: false, errorMsg: "Password cannot be part of the email.")
//        }
//
//        // Check for common weak passwords
//        let commonPasswords = ["123456", "12345678", "qwerty", "password", "pass"] //Add more restrictions if needed
//        if commonPasswords.contains(self.lowercased()) {
//            return (isValid: false, errorMsg: "Password is too common.")
//        }
//
//        if self != password {
//            return (isValid: false, errorMsg: "Passwords don't match.")
//        }
//        // If all checks pass, the password is valid
//        return (isValid: true, errorMsg: "")
//    }
//}
