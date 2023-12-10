//
//  MailButtonViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 22/11/23.
//

import SwiftUI
import MessageUI

/**
 A SwiftUI view component representing a button for contacting support via email.

 - Note: This component utilizes `MFMailComposeViewController` for sending emails.
 - Parameters:
   - authViewModel: The view model managing user authentication.
   - sendEmailResult: Binding to track the result of the mail composition.
   - errorContactSupport: Binding to indicate whether there was an error contacting support.
   - isShowingEmailView: Binding to control the presentation of the email compose view.
   - emailBody: Binding to provide the body content for the email.
   - emailData: Binding to store email data including recipients, subject, and body.
 */
struct MailButtonViewComponent: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    
    @Binding var sendEmailResult: Result<MFMailComposeResult, Error>?
    @Binding var errorContactSupport: Bool
    @Binding var isShowingEmailView: Bool
    @Binding var emailBody: String
    @Binding var emailData: EmailDataModel?
    
    var body: some View{
        Button {
            if MFMailComposeViewController.canSendMail() {
                if let id = self.authViewModel.userData?.id, let email = authViewModel.userData?.email {
                    self.emailData = EmailDataModel(id: id, email: email)
                    self.isShowingEmailView.toggle()
                }
                else {
                    self.errorContactSupport.toggle()
                }
            }
            else {
                self.errorContactSupport.toggle()
            }
        } label: {
            Label("Contact Support", systemImage: "envelope.fill")
                .bold()
        }
        .background(Color.clear)
        .foregroundColor(Color.accentColor)
        .cornerRadius(10)
    }
}

#Preview {
    MailButtonViewComponent(authViewModel: AuthViewModel(), sendEmailResult: .constant(nil), errorContactSupport: .constant(false), isShowingEmailView: .constant(false), emailBody: .constant("Body"), emailData: .constant(nil))
}
