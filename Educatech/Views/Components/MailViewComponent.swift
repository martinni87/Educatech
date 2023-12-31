//
//  MailView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 9/10/23.
//

import UIKit
import SwiftUI
import MessageUI

/**
 A SwiftUI view component representing a mail compose view.

 - Note: This component uses `MFMailComposeViewController` to create a mail compose view for sending emails.
 - Parameters:
   - presentation: The presentation mode environment variable for managing the view presentation.
   - result: Binding to track the result of the mail composition.
   - emailData: Binding to provide email data including recipients, subject, and body.
 */
struct MailViewComponent: UIViewControllerRepresentable {
    
    @Environment (\.presentationMode) var presentation
    @Binding var result: Result<MFMailComposeResult, Error>?
    @Binding var emailData: EmailDataModel?
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        
        @Binding var presentation: PresentationMode
        @Binding var result: Result<MFMailComposeResult, Error>?
        @Binding var emailData: EmailDataModel?
        
        init(presentation: Binding<PresentationMode>,
             result: Binding<Result<MFMailComposeResult, Error>?>,
             emailData: Binding<EmailDataModel?>) {
            _presentation = presentation
            _result = result
            _emailData = emailData
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController,
                                  didFinishWith result: MFMailComposeResult,
                                  error: Error?) {
            defer {
                $presentation.wrappedValue.dismiss()
            }
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            self.result = .success(result)
        }
    }
    
    func makeCoordinator() -> Coordinator {
            return Coordinator(presentation: presentation,
                               result: $result, emailData: $emailData)
        }

        func makeUIViewController(context: UIViewControllerRepresentableContext<MailViewComponent>) -> MFMailComposeViewController {
            let vc = MFMailComposeViewController()
            vc.setToRecipients([emailData!.recipients])
            vc.setSubject(emailData!.subject)
            vc.setMessageBody(emailData!.body, isHTML: true)
            vc.mailComposeDelegate = context.coordinator
            return vc
        }

        func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailViewComponent>) {}
}

