//
//  StringExtensions.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 26/9/23.
//
import Foundation

/// A set of extensions for the `String` class, providing various validation and utility functions.
extension String {

    /**
     Validates whether the string is not empty.
     
     - Parameters:
        - completionBlock: A closure to handle the validation result, containing a boolean indicating validity and an optional error message.
     */
    func fieldIsNotEmpty(completionBlock: @escaping (Bool, String?) -> Void) {
        if self.isEmpty || self == "" {
            completionBlock(false, "All fields are mandatory. Please, try again.")
            return
        }
        //Last result, everything's ok
        completionBlock(true, nil)
    }
    
    /**
     Validates whether the title string contains forbidden characters.
     
     - Parameters:
        - completionBlock: A closure to handle the validation result, containing a boolean indicating validity and an optional error message.
     */
    func validateTitle(completionBlock: @escaping (Bool, String?) -> Void) {
        let forbiddenCharacters = #"@/\\|\"'`´^*+<>ºª°¸˛…—·#$%&()"#
        
        // Check if the string contains any forbidden characters
        self.fieldIsNotEmpty { isNotEmpty, errorMsg in
            if !isNotEmpty {
                completionBlock(false, errorMsg)
                return
            }
            if self.rangeOfCharacter(from: CharacterSet(charactersIn: forbiddenCharacters)) != nil {
                completionBlock(false, "Title contains forbidden characters.")
                return
            }
            //Last result, everything's ok
            completionBlock(true, nil)
        }
    }
    
    /**
     Validates whether the string is a well-formatted URL.
     
     - Parameters:
        - completionBlock: A closure to handle the validation result, containing a boolean indicating validity and an optional error message.
     */
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
    
    /**
     Validates whether the string is a well-formatted email address.
     
     - Parameters:
       - completionBlock: A closure to handle the validation result, containing a boolean indicating validity and an optional error message.
     */
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
    
    /**
     Validates whether the string is a well-formatted password, considering various criteria.
     
     - Parameters:
       - email: The email to check against.
       - completionBlock: A closure to handle the validation result, containing a boolean indicating validity and an optional error message.
     */
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
    
    /**
     Validates whether the string matches a repeated password.
     
     - Parameters:
       - password: The original password to compare against.
       - completionBlock: A closure to handle the validation result, containing a boolean indicating validity and an optional error message.
     */
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
