//
//  EmailData.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 9/10/23.
//

import Foundation

/**
 A model representing email data for contacting support.
 
 - Important: The `id` and `email` properties are private, and their values are set through the initializer.
 - Note: This model is used to generate an email body with pre-filled information.
 */
struct EmailDataModel {
    private var id: String = "0000" /// The private unique identifier associated with the email data.
    private var email: String = "No mail" /// The private email address associated with the email data.
    let recipients = "supportIT@educatech.com" /// The recipients of the email.
    let subject = "Support Educatech App for iOS" /// The subject of the email.
    var body: String = "" /// The body of the email, containing pre-filled information.
    
    /**
     Initializes a new instance of `EmailDataModel` with the specified identifier and email.
     
     - Parameters:
        - id: The unique identifier associated with the email data.
        - email: The email address associated with the email data.
     */
    init(id: String, email: String) {
        self.id = id
        self.email = email
        self.body =
        """
        <h1> Contact Support Educatech iOS </h1>
        <ul>
            <li><strong>UUID: </strong>\(id)</li>
            <li><strong>Email: </strong>\(email)</li>
        </ul>
        <h3>Please, describe the issue you're encountering, a request or any comment you might want to share with us:</h3>
        <p></p>
        """
    }
}
