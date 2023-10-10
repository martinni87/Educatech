//
//  CreateCourseView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 22/9/23.
//

import SwiftUI
import Firebase
import FirebaseStorage
import PhotosUI

struct CreateCourseView: View {
    
    // Presentation mode for dismissing the current view
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    //Binding View Models
    @Binding var authViewModel: AuthViewModel
    @ObservedObject var coursesViewModel: CoursesViewModel
    
    //Form values
    @State var title: String = ""
    @State var description: String = ""
    @State var image: String = ""
    
    @State var showMsg: Bool = false
    @State var thereIsError: Bool = false
    @State var message: String = "New course created successfully! 😎"
    
    var body: some View {
        ScrollView {
            if verticalSizeClass == .compact {
                HStack (alignment: .firstTextBaseline, spacing: 20){
                    CreationFormPart(title: $title,
                                     description: $description,
                                     image: $image,
                                     showMsg: $showMsg,
                                     thereIsError: $thereIsError,
                                     message: $message)
                }
            }
            else {
                VStack {
                    Image("video-editing")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                    CreationFormPart(title: $title,
                                     description: $description,
                                     image: $image,
                                     showMsg: $showMsg,
                                     thereIsError: $thereIsError,
                                     message: $message)
                }
            }
            Button {
                coursesViewModel.createNewCourse(title: title,
                                                 description: description,
                                                 image: image,
                                                 creatorID: authViewModel.user?.id ?? "")
                if let error = coursesViewModel.error {
                    thereIsError = true
                    message = error
                }
                showMsg = true
                
            } label: {
                Text("Create")
            }
            .buttonStyle(.bordered)
            .tint(.green)
        }
        
        
        .onAppear {
            description = KLOREMIPSUM
        }
        .padding(30)
        .alert(isPresented: $showMsg) {
            Alert(title: Text(thereIsError ? "Something went wrong" : "Congratulations!"),
                  message: Text(self.message),
                  dismissButton: .default(Text("OK")) {
                // Dismiss the current view and go back to the previous one
                if !thereIsError {
                    self.title = ""
                    self.description = ""
                    self.image = ""
                    presentationMode.wrappedValue.dismiss()
                }
                self.showMsg = false
                self.thereIsError = false
                self.message = "New course created successfully! 😎"
            })
        }
        .navigationTitle("New course creation")
    }
}

struct CreationFormPart: View {
    
    //Form values
    @Binding var title: String
    @Binding var description: String
    @Binding var image: String
    
    @Binding var showMsg: Bool
    @Binding var thereIsError: Bool
    @Binding var message: String
    
    var body: some View {
        Group {
            VStack {
                FormField(fieldType: .singleLine,
                          label: "Title",
                          placeholder: "Title",
                          variable: $title,
                          autocapitalization: true)
                FormField(fieldType: .singleLine,
                          label: "Image URL",
                          placeholder: "https://www.image.com/image.jpg",
                          tooltip: "You can choose any picture you like from the internet if you have a valid URL address",
                          variable: $image,
                          autocapitalization: false)
            }
            FormField(fieldType: .multiLine,
                      label: "Description",
                      placeholder: "Write some description here...",
                      variable: $description,
                      autocapitalization: true)
        }
    }
}

struct CreateCourseView_Previews: PreviewProvider {
    
    @State static var authViewModel: AuthViewModel = AuthViewModel()
    @State static var coursesViewModel: CoursesViewModel = CoursesViewModel()
    
    static var previews: some View {
        CreateCourseView(authViewModel: $authViewModel, coursesViewModel: coursesViewModel)
    }
}
