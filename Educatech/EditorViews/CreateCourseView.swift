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
        ScrollView {
            VStack (alignment: .leading){
                CreationFormField(fieldType: .singleLine,
                                  title: "Title",
                                  variable: $title,
                                  autocapitalization: true)
                CreationFormField(fieldType: .singleLine,
                                  title: "Image URL",
                                  variable: $image,
                                  autocapitalization: false)
                CreationFormField(fieldType: .multiLine,
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


struct CreationFormField: View {
    
    @State var fieldType: FormFieldTypes
    @State var title: String
    @Binding var variable: String
    @State var autocapitalization: Bool
    @State var editing = false
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(title)
                .foregroundColor(.gray)
                .bold()
            if fieldType == .multiLine {
                TextEditor(text: $variable)
                    .padding(.horizontal,5)
                    .frame(height: 150)
                    .foregroundColor(!editing ? .gray : .black)
                    .border(.gray.opacity(0.3), width: 1)
                    .padding(.bottom, 20)
                    .onTapGesture {
                        variable = ""
                        editing = true
                    }
            }
            else {
                TextField(title, text: $variable)
                    .textInputAutocapitalization(!autocapitalization ? .never : .sentences)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom, 20)
            }
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
