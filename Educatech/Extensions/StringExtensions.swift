//
//  StringExtensions.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 26/9/23.
//
import Foundation

extension String {
    
    func localized() -> String {
        let translated = String(localized: LocalizedStringResource(stringLiteral: self))
        return translated
    }
    
    func validateURLString() -> (isValid: Bool, errorMsg: String) {
        let urlRegex = #"^(https?|ftp)://[^\s/$.?#]+.*$"# // Regular expression for URL validation
        let urlTest = NSPredicate(format: "SELF MATCHES %@", urlRegex)
        if !urlTest.evaluate(with: self.lowercased()) {
            return (isValid: false, errorMsg: "URL String badly formatted")
        }
        return (isValid: true, errorMsg: "")
    }
    
    func validateNotEmptyString() -> (isValid: Bool, errorMsg: String) {
        if self.isEmpty || self == "" {
            return (isValid: false, errorMsg: "All fields are mandatory")
        }
        return (isValid: true, errorMsg: "")
    }

    func validateEmail() -> (isValid: Bool, errorMsg: String) {
        /**
         * isValidEmail function uses a regular expression pattern that checks for a typical email format.
         * It allows letters, digits, plus signs, underscores, fots and hyphens before "@" symbol
         * It also allows any domain name after the "@" symbol. This pattern aligns with most used email formats
         */
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let emailIsValid = emailTest.evaluate(with: self)
        //Checking if email is not valid
        if !emailIsValid {
            return (isValid: false, errorMsg: "Email is badly formatted. Please, try again.")
        }
        
        // If all checks pass, the password is valid
        return (isValid: true, errorMsg: "")
    }

    func validatePassword(for email: String) -> (isValid: Bool, errorMsg: String) {
        // Check for minimum and maximum length
        if !(6...12).contains(self.count) {
            return (isValid: false, errorMsg: "Password must be between 6 and 12 characters.")
        }

        // Check for at least 1 letter, 1 number, and 1 symbol
        let letterPredicate = NSPredicate(format: "SELF MATCHES %@", ".*[A-Za-z]+.*")
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", ".*\\d+.*")
        let symbolPredicate = NSPredicate(format: "SELF MATCHES %@", ".*[@*\\-+_\\.?!]+.*")

        if !letterPredicate.evaluate(with: self) {
            return (isValid: false, errorMsg: "Password must contain at least 1 letter.")
        }
        
        if !numberPredicate.evaluate(with: self) {
            return (isValid: false, errorMsg: "Password must contain at least 1 number.")
        }

        if !symbolPredicate.evaluate(with: self) {
            return (isValid: false, errorMsg: "Password must contain at least 1 of the following symbols: \("* + - _ . ? !") ")
        }

        // Check for at least 1 lowercase and 1 uppercase letter
        let lowercasePredicate = NSPredicate(format: "SELF MATCHES %@", ".*[a-z]+.*")
        let uppercasePredicate = NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*")

        if !lowercasePredicate.evaluate(with: self) || !uppercasePredicate.evaluate(with: self) {
            return (isValid: false, errorMsg: "Password must contain at least 1 lowercase and 1 uppercase letter.")
        }

        // Check if it's part of the given email
        if email.lowercased().contains(self.lowercased()) {
            return (isValid: false, errorMsg: "Password cannot be part of the email.")
        }

        // Check for common weak passwords
        let commonPasswords = ["123456", "12345678", "qwerty", "password", "pass"]
        if commonPasswords.contains(self.lowercased()) {
            return (isValid: false, errorMsg: "Password is too common.")
        }

        // If all checks pass, the password is valid
        return (isValid: true, errorMsg: "")
    }
}
