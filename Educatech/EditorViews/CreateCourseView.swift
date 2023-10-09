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
            VStack (alignment: .leading){
                FormField(fieldType: .singleLine,
                                  title: "Title",
                                  variable: $title,
                                  autocapitalization: true)
                FormField(fieldType: .singleLine,
                                  title: "Image URL",
                                  variable: $image,
                                  autocapitalization: false)
                FormField(fieldType: .multiLine,
                                  title: "Description",
                                  variable: $description,
                                  autocapitalization: true)
            }
            .onAppear {
                description = KLOREMIPSUM
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




struct CreateCourseView_Previews: PreviewProvider {
    
    @State static var authViewModel: AuthViewModel = AuthViewModel()
    @State static var coursesViewModel: CoursesViewModel = CoursesViewModel()
    
    static var previews: some View {
        CreateCourseView(authViewModel: $authViewModel, coursesViewModel: coursesViewModel)
    }
}
