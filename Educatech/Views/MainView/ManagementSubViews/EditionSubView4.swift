//
//  EditionSubView4.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 27/11/23.
//

import SwiftUI
import PhotosUI

/// The fourth step in the course editing process.
///
/// This view allows the user to modify the thumbnail picture of the selected course.
///
/// - Parameters:
///   - authViewModel: An observed object representing the authentication view model.
///   - collectionsViewModel: An observed object representing the collections view model.
///   - course: A binding variable representing the course to be edited.
///   - newValues: Stores the new values inputed
///   - changePictureAlert: if the user attemps to change the picture stored, an alert will show
///   - storageError: any error delivered by an issue while storing new data
struct EditionSubView4: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @Binding var course: CourseModel
    @State var newValues = CreateCourseFormInputs()
    @State var changePictureAlert: Bool = false
    @State var storageError: Bool = false
    
    @State var goHomeAlert: Bool = false
    @State var goHome: Bool = false
    
    @Environment (\.verticalSizeClass) var verticalSizeClass
    @Environment (\.horizontalSizeClass) var horizontalSizeClass
    @Environment (\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            Text("Thumbnail picture")
                .font(.title)
                .bold()
            VStack {
                Spacer()
                ZStack {
                    AsyncImageViewComponent(course: $course)
                        .scaledToFill()
                        .frame(maxHeight: verticalSizeClass == .compact ? 100 : 425)
                        .frame(maxWidth: 850)
                        .clipShape(.rect(cornerRadius: horizontalSizeClass == .compact ? 0 : 10))
                        .clipped()
                    if newValues.selectedPicture != nil {
                        Text("↺")
                            .padding(.top, 170)
                            .padding(.leading,240)
                            .foregroundStyle(Color.pink)
                            .bold().font(.largeTitle)
                    }
                }
                if newValues.selectedPicture == nil {
                    Text("There are still no changes. Click on 'Select' to choose a new picture")
                        .font(.caption)
                        .bold()
                        .foregroundStyle(Color.gray)
                        .padding()
                }
                else {
                    Text("New picture id: \(newValues.selectedPicture?.itemIdentifier ?? "No id")")
                        .font(.caption)
                        .bold()
                        .foregroundStyle(Color.accentColor)
                        .padding()
                }
                HStack {
                    Rectangle()
                        .fill(colorScheme == .light ? .black.opacity(0.1) : .white.opacity(0.1))
                        .frame(height: 40)
                        .frame(width: 150)
                        .cornerRadius(10)
                        .overlay {
                            GalleryPhotoViewComponent(collectionsViewModel: collectionsViewModel, selectedPicture: $newValues.selectedPicture)
                        }
                        .padding()
                    Button {
                        changePictureAlert.toggle()
                    } label: {
                        ButtonViewComponent(title: "Submit changes", foregroundColor: .gray.opacity(0.1), titleColor: .accentColor)
                            .disabled(newValues.selectedPicture == nil)
                    }
                    .padding()
                }
                Spacer()
                NavigationLink {
                    EditionSubView5(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel, course: $course)
                } label: {
                    Label("Edit videos", systemImage: "video.badge.plus").bold()
                }
                .padding()
            }
            .frame(maxWidth: 850)
            .onChange(of: collectionsViewModel.singleCourse) { _, newValue in
                course = newValue
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button("Go Home"){
                        self.goHomeAlert.toggle()
                    }
                })
            }
            //Alert in case user wants to change the thumbnail picture
            .alert("Change picture", isPresented: $changePictureAlert){
                Button("Yes") {
                    StorageManager().uploadPicture(courseID: course.id!, photoItem: newValues.selectedPicture!) { result in
                        switch result {
                        case .failure(_):
                            self.storageError = true
                        case .success(let url):
                            collectionsViewModel.editCourseData(
                                changeTo: CourseModel(id: course.id ?? "0",
                                                      creatorID: course.creatorID,
                                                      teacher: course.teacher,
                                                      title: course.title,
                                                      description: course.description,
                                                      imageURL: url,
                                                      category: course.category,
                                                      videosURL: course.videosURL,
                                                      numberOfStudents: course.numberOfStudents,
                                                      approved: course.approved))
                            newValues = CreateCourseFormInputs()
                            changePictureAlert = false
                            storageError = false
                        }
                    }
                }
                Button("No") {
                    print("Cancel changes")
                }
            } message: {
                Text("Are you sure you want to change the picture? This action cannot be undone.")
            }
            //In case user wants to quit
            .alert("Go to Homescreen?", isPresented: $goHomeAlert) {
                Button("Yes"){
                    goHome.toggle()
                }
                Button("No") {}
            } message: {
                Text("Are you sure you want to quit editing? All unsaved changes will be lost")
            }
            //If user validates exit
            .fullScreenCover(isPresented: $goHome) {
                MainView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
            }
        }
    }
}

#Preview {
    EditionSubView4(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel(), course: .constant(CourseModel(creatorID: "", teacher: "", title: "Example title", description: "A not so long example description of a course", imageURL: "No picture", category: "Swift")))
}
