//
//  CreationView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 22/9/23.
//

import SwiftUI
import Firebase
import FirebaseStorage
import PhotosUI

struct CreationView: View {
    
    //Binding View Models
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var coursesViewModel: CoursesViewModel
    
    // Presentation mode for dismissing the current view
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    //Form values
    @State var formParameters = CreationFormParameters()
    @State var errorParameters = ErrorParameters()
    
    var body: some View {
        ScrollView {
            if verticalSizeClass == .compact {
                HStack (alignment: .firstTextBaseline, spacing: 20){
                    CreationForm(formParameters: $formParameters)
                }
            }
            else {
                VStack {
                    Image("video-editing")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                    CreationForm(formParameters: $formParameters)
                }
            }
            Button {
                if let email = authViewModel.user?.email {
                    coursesViewModel.createNewCourse(title: formParameters.title,
                                                     description: formParameters.description,
                                                     imageURL: formParameters.imageURL,
                                                     creatorID: authViewModel.user?.id ?? "",
                                                     teacher: String(email.prefix(upTo: email.firstIndex(of: "@")!)),
                                                     category: formParameters.category/*,*/
                                                     /*price: Double(formParameters.price) ?? 0.00*/)
                }
                if let error = coursesViewModel.error {
                    errorParameters.thereIsError = true
                    errorParameters.message = error
                }
                errorParameters.showMsg = true
                
            } label: {
                Text("Create")
            }
            .buttonStyle(.bordered)
            .tint(.green)
        }
        .onAppear {
            formParameters.description = KLOREMIPSUM
        }
        .padding(30)
        .alert(isPresented: $errorParameters.showMsg) {
            Alert(title: Text(errorParameters.thereIsError ? "Something went wrong" : "Congratulations!"),
                  message: Text(errorParameters.message),
                  dismissButton: .default(Text("OK")) {
                // Dismiss the current view and go back to the previous one
                if !errorParameters.thereIsError {
                    formParameters.title = ""
                    formParameters.description = ""
                    formParameters.imageURL = ""
                    presentationMode.wrappedValue.dismiss()
                }
                errorParameters.showMsg = false
                errorParameters.thereIsError = false
                errorParameters.message = "New course created successfully! 😎"
            })
        }
        .navigationTitle("New course creation")
    }
}

struct CreationView_Previews: PreviewProvider {
    
    @State static var coursesViewModel = CoursesViewModel()
    @State static var authViewModel = AuthViewModel()
    static var previews: some View {
        CreationView(authViewModel: authViewModel, coursesViewModel: coursesViewModel)
    }
}
