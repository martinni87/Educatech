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
    @Binding var coursesViewModel: CoursesViewModel
    
    //Form values
    @State var title: String = ""
    @State var description: String = ""
    @State var image: String = ""
    
    @State var showMsg: Bool = false
    @State var thereIsError: Bool = false
    @State var message: String = "New course created successfully! 😎"
    
    var body: some View {
        VStack {
            Text("Create a new course")
                .font(.largeTitle)
                .bold()
            Spacer()
            VStack (spacing: 20){
                TextField("Title", text: $title)
                TextField("Description", text: $description)
                TextField("Image url", text: $image)
                    .textInputAutocapitalization(.never)
            }
            .textFieldStyle(.roundedBorder)
            Spacer()
            Button {
                
                coursesViewModel.createNewCourse(title: title,
                                                 description: description,
                                                 image: image)
                if let error = coursesViewModel.error {
                    thereIsError = true
                    message = error
                }
                showMsg = true
                
            } label: {
                Text("Create")
            }
            .buttonStyle(.bordered)
            .tint(.orange)
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
    }
}

struct CreateCourseView_Previews: PreviewProvider {

    @State static var authViewModel: AuthViewModel = AuthViewModel()
    @State static var coursesViewModel: CoursesViewModel = CoursesViewModel()

    static var previews: some View {
        CreateCourseView(authViewModel: $authViewModel, coursesViewModel: $coursesViewModel)
    }
}
