////
////  ManagedCourseDetailView.swift
////  Educatech
////
////  Created by Martín Antonio Córdoba Getar on 7/10/23.
////
//
//import SwiftUI
//
//struct ManagedCourseDetailView: View {
//    
//    // Presentation mode for dismissing the current view
//    @Environment(\.presentationMode) var presentationMode
//    
//    @Binding var course: CourseModel
//    @ObservedObject var coursesViewModel: CoursesViewModel
//    
//    @State var formParameters = CreationFormParameters()
//    @State var errorParameters = ErrorParameters()
//    
//    var body: some View {
//        NavigationStack {
//            Form {
//                Section("Course information") {
//                    Group { Text("ID: ").bold() + Text(course.id ?? "No id") } .foregroundColor(.gray)
//                    Group { Text("Creator ID: ").bold() + Text(course.creatorID) } .foregroundColor(.gray)
//                    HStack {
//                        Text("Title: ").bold()
//                        TextField("Title", text: $formParameters.title)
//                        Image(systemName: "square.and.pencil")
//                            .foregroundColor(.gray)
//                    }
//                    HStack {
//                        Text("Image URL: ").bold()
//                        TextField("Image", text: $formParameters.imageURL)
//                        Image(systemName: "square.and.pencil")
//                            .foregroundColor(.gray)
//                    }
//                    HStack {
//                        VStack (alignment: .leading) {
//                            Text("Description: ").bold()
//                            TextEditor(text: $formParameters.description)
//                                .frame(minHeight: 50)
//                        }
//                        Image(systemName: "square.and.pencil")
//                            .foregroundColor(.gray)
//                    }
//                }
//                .onAppear {
//                    formParameters.title =  course.title
//                    formParameters.imageURL  = course.imageURL
//                    formParameters.description = course.description
//                }
//                Section("Multimedia") {
//                    NavigationLink {
//                        AddNewVideosView()
//                    } label: {
//                        Text("Add new videos")
//                            .foregroundStyle(Color.blue)
//                    }
//                }
//                .navigationTitle("Editing: \(course.id!)")
//            }
//            HStack {
//                Spacer()
//                Button("Save changes"){
//                    coursesViewModel.updateCourseData(courseID: course.id!,
//                                                      title: formParameters.title,
//                                                      description: formParameters.description,
//                                                      imageURL: formParameters.imageURL,
//                                                      category: formParameters.category/*,*/
//                                                      /*price: 0.00*/)
//                    if let error = coursesViewModel.error {
//                        errorParameters.thereIsError = true
//                        errorParameters.message = error
//                    }
//                    errorParameters.showMsg = true
//                }
//                .tint(.green)
//                .bold()
//                Spacer()
//                Button("Delete course"){
//                    print("Delete course")
//                }
//                .tint(.pink)
//                Spacer()
//            }
//            .alert(isPresented: $errorParameters.showMsg) {
//                Alert(title: Text(errorParameters.thereIsError ? "Something went wrong" : "Congratulations!"),
//                      message: Text(errorParameters.message),
//                      dismissButton: .default(Text("OK")) {
//                    // Dismiss the current view and go back to the previous one
//                    if !errorParameters.thereIsError {
//                        formParameters = CreationFormParameters()
//                        presentationMode.wrappedValue.dismiss()
//                    }
//                    errorParameters = ErrorParameters()
//                })
//            }
//        }
//    }
//}
//
//struct ManagedCourseDetailView_Previews: PreviewProvider {
//    
//    @State static var course: CourseModel = COURSE_LIST_EXAMPLE[0]
//    @State static var coursesViewModel = CoursesViewModel()
//    
//    static var previews: some View {
//        ManagedCourseDetailView(course: $course, coursesViewModel: coursesViewModel)
//    }
//}
