////
////  EditionSubView2.swift
////  Educatech
////
////  Created by Martín Antonio Córdoba Getar on 21/11/23.
////
//
//import SwiftUI
//import PhotosUI
//
//struct EditionSubView2: View {
//    
//    @ObservedObject var authViewModel: AuthViewModel
//    @ObservedObject var collectionsViewModel: CollectionsViewModel
//    @State var course: CourseModel
//    @State var newValues = CreateCourseFormInputs()
//    @State var listOfVideosBackup: [String] = []
//    @State var currentListOfVideos: [String] = []
//    @State var changeInfoAlert: Bool = false
//    @State var changePictureAlert: Bool = false
//    @State var changeVideosAlert: Bool = false
//    @State var emptyVideosAlert: Bool = false
//    @State var noChangesAlert: Bool = false
//    @State var storageError: Bool = false
//    @Environment (\.colorScheme) var colorScheme
//    @Environment (\.verticalSizeClass) var verticalSizeClass
//    @Environment (\.horizontalSizeClass) var horizontalSizeClass
//    
//    var body: some View {
//        NavigationStack {
//            List {
//                //MARK: Section of course info (title, description and category)
//                Section {
//                    CourseInfoSection(collectionsViewModel: collectionsViewModel,
//                                      course: $course,
//                                      newValues: $newValues,
//                                      changeInfoAlert: $changeInfoAlert,
//                                      noChangesAlert: $noChangesAlert)
//                } header: {
//                    VStack (alignment: .leading) {
//                        Text("Course info")
//                            .foregroundColor(Color.gray)
//                            .bold()
//                        Text("Title, description and category")
//                    }
//                } footer: {
//                    Text("Changes won't take place until you 'Submit changes'. Leave blank to keep current value")
//                }
//                
//                //MARK: Section to change pictures
//                Section {
//                    CoursePictureSection(collectionsViewModel: collectionsViewModel,
//                                         course: $course,
//                                         newValues: $newValues,
//                                         changePictureAlert: $changePictureAlert,
//                                         noChangesAlert: $noChangesAlert,
//                                         storageError: $storageError)
//                } header: {
//                    Text("Image")
//                        .foregroundStyle(Color.gray)
//                        .bold()
//                } footer: {
//                    Text("Changes won't take place until you 'Submit changes'. Leave blank to keep current value")
//                }
//                
//                //MARK: Section to change videos
//                Section {
//                    CourseVideosSection(collectionsViewModel: collectionsViewModel,
//                                        course: $course,
//                                        newValues: $newValues,
//                                        listOfVideosBackup: $listOfVideosBackup,
//                                        currentListOfVideos: $currentListOfVideos,
//                                        changeVideosAlert: $changeVideosAlert,
//                                        emptyVideosAlert: $emptyVideosAlert,
//                                        noChangesAlert: $noChangesAlert,
//                                        storageError: $storageError)
//                } header: {
//                    Text("Videos")
//                        .foregroundStyle(Color.gray)
//                        .bold()
//                } footer: {
//                    Text("Changes won't take place until you 'Submit changes'. At least you need one video. Mark to delete existing URLs by swiping left")
//                }
//                
//            }
//            .frame(maxWidth: 850)
//            .scrollContentBackground((horizontalSizeClass == .regular && verticalSizeClass == .regular) ? .hidden : .visible)
//        }
//        .onChange(of: collectionsViewModel.singleCourse) { _, newValue in
//            self.course = newValue
//        }
//        // For each change attemp a warning message will show for confirmation
//        .alert("Change info", isPresented: $changeInfoAlert) {
//            Button("Yes") {
//                collectionsViewModel.editCourseData(
//                    changeTo: CourseModel(id: course.id ?? "0",
//                                          creatorID: course.creatorID,
//                                          teacher: course.teacher,
//                                          title: newValues.title == "" ? course.title : newValues.title,
//                                          description: newValues.description == "" ? course.description : newValues.description,
//                                          imageURL: course.imageURL,
//                                          category: newValues.category == "" ? course.category : newValues.category,
//                                          videosURL: course.videosURL,
//                                          numberOfStudents: course.numberOfStudents,
//                                          approved: course.approved))
//            }
//            Button("No") {
//                print("Cancel changes")
//            }
//        } message: {
//            Text("Are you sure you want to change the title? Changes cannot be undone")
//        }
//        .alert("Change picture", isPresented: $changePictureAlert){
//            Button("Yes") {
//                StorageManager().uploadPicture(courseID: course.id!, photoItem: newValues.selectedPicture!) { result in
//                    switch result {
//                    case .failure(_):
//                        self.storageError = true
//                    case .success(let url):
//                        collectionsViewModel.editCourseData(
//                            changeTo: CourseModel(id: course.id ?? "0",
//                                                  creatorID: course.creatorID,
//                                                  teacher: course.teacher,
//                                                  title: course.title,
//                                                  description: course.description,
//                                                  imageURL: url,
//                                                  category: course.category,
//                                                  videosURL: course.videosURL,
//                                                  numberOfStudents: course.numberOfStudents,
//                                                  approved: course.approved))
//                    }
//                }
//            }
//            Button("No") {
//                print("Cancel changes")
//            }
//        } message: {
//            Text("Are you sure you want to change the picture? Changes cannot be undone")
//        }
//        .alert("Change videos", isPresented: $changeVideosAlert){
//            Button("Yes") {
//                print("Perform changes")
//            }
//            Button("No") {
//                print("Cancel changes")
//            }
//        } message: {
//            Text("Are you sure you want to change the picture? Changes cannot be undone")
//        }
//        //No changes alert, when a user hits submit without new data
//        .alert("Nothing to do!", isPresented: $noChangesAlert) {
//            Button("OK") {
//                print("Nothing to do")
//            }
//        } message: {
//            Text("There are no changes to be done. Please complete some fields and submit again.")
//        }
//        .alert("Error uploading file", isPresented: $storageError) {
//            Button("OK") {
//                print("OK")
//            }
//        } message: {
//            Text("Something went wrong uploading to the server. Please, try again later. If the problem persist contact the Admin.")
//        }
//    }
//}
//

//
//struct CoursePictureSection: View {
//    
//    @ObservedObject var collectionsViewModel: CollectionsViewModel
//    @Binding var course: CourseModel
//    @Binding var newValues: CreateCourseFormInputs
//    @Binding var changePictureAlert: Bool
//    @Binding var noChangesAlert: Bool
//    @Binding var storageError: Bool
//    @Environment (\.horizontalSizeClass) var horizontalSizeClass
//    
//    var body: some View {
//        AsyncImage(url: URL(string: course.imageURL)) { phase in
//            if let image = phase.image {
//                image
//                    .resizable()
//                    .scaledToFill()
//                    .frame(height: horizontalSizeClass == .compact ? 200 : 300)
//                    .clipShape(.rect(cornerRadius: 5))
//            }
//        }
//        if newValues.selectedPicture == nil {
//            Text("There are still no changes. Click on 'Select' to choose a new picture")
//                .font(.caption)
//                .bold()
//                .foregroundStyle(Color.gray)
//        }
//        else {
//            Text("New picture id: \(newValues.selectedPicture?.itemIdentifier ?? "No id")")
//                .font(.caption)
//                .bold()
//                .foregroundStyle(Color.accentColor)
//        }
//        PhotosPicker(selection: $newValues.selectedPicture, matching: .images, photoLibrary: .shared()) {
//            Label("Select new picture", systemImage: "photo.badge.plus")
//        }
//        if newValues.selectedPicture != nil {
//            Button {
//                newValues.selectedPicture = nil
//            } label: {
//                Label("Reset", systemImage: "xmark")
//            }
//        }
//        HStack {
//            Button("Submit change") {
//                if newValues.selectedPicture == nil {
//                    noChangesAlert.toggle()
//                }
//                else {
//                    changePictureAlert.toggle()
//                }
//            }
//            .bold()
//        }
//        HStack {
//            Button("Reset info") {
//                newValues.selectedPicture = nil
//            }
//            .bold()
//            .foregroundStyle(Color.pink)
//        }
//    }
//}
//
//struct CourseVideosSection: View {
//    
//    @ObservedObject var collectionsViewModel: CollectionsViewModel
//    @Binding var course: CourseModel
//    @Binding var listOfVideosBackup: [String]
//    @Binding var currentListOfVideos: [String]
//    @Binding var newValues: CreateCourseFormInputs
//    @Binding var changeVideosAlert: Bool
//    @Binding var emptyVideosAlert: Bool
//    @Binding var noChangesAlert: Bool
//    @Binding var storageError: Bool
//    
//    var body: some View {
//        Group {
//            Text("Current videos URLs:").foregroundStyle(Color.gray).font(.caption)
//            ForEach(currentListOfVideos, id:\.self) { videoURL in
//                Text(videoURL).bold().foregroundStyle(Color.gray).font(.caption)
//                    .lineLimit(1)
//                    .swipeActions {
//                        Button("Delete"){
//                            currentListOfVideos.removeAll { $0 == videoURL }
//                        }
//                        .tint(Color.pink)
//                    }
//            }
//            if !newValues.selectedVideos.isEmpty {
//                Text("New videos to upload:").foregroundStyle(Color.gray).font(.caption)
//                ForEach(newValues.selectedVideos, id:\.self) { selectedVideos in
//                    Text(selectedVideos.itemIdentifier ?? "No id")
//                        .font(.caption)
//                        .bold()
//                        .foregroundStyle(Color.accentColor)
//                }
//            }
//            else {
//                Text("There are still no changes. Click on 'Select' to choose a new video")
//                    .font(.caption)
//                    .bold()
//                    .foregroundStyle(Color.gray)
//            }
//            PhotosPicker(selection: $newValues.selectedVideos, selectionBehavior: .default, matching: .videos, preferredItemEncoding: .compatible, photoLibrary: .shared()) {
//                Label("Select new videos", systemImage: "video.badge.plus")
//            }
//            if !newValues.selectedVideos.isEmpty {
//                Button {
//                    newValues.selectedVideos = []
//                } label: {
//                    Label("Reset", systemImage: "xmark")
//                }
//            }
//            HStack {
//                Button("Submit changes") {
//                    if newValues.selectedVideos.isEmpty && currentListOfVideos == listOfVideosBackup {
//                        noChangesAlert.toggle()
//                    }
//                    else if newValues.selectedVideos.isEmpty && currentListOfVideos.isEmpty {
//                        emptyVideosAlert.toggle()
//                    }
//                }
//                .bold()
//            }
//            HStack {
//                Button("Reset info") {
//                    currentListOfVideos = listOfVideosBackup
//                    newValues.selectedVideos = []
//                }
//                .bold()
//                .foregroundStyle(Color.pink)
//            }
//        }
//        .onAppear{
//            currentListOfVideos = course.videosURL
//            listOfVideosBackup = course.videosURL
//        }
//        .onChange(of: currentListOfVideos) { _, _ in
//            print("Backup: \(listOfVideosBackup)")
//            print("Current list: \(currentListOfVideos)")
//        }
//    }
//}
//
//#Preview {
//    EditionSubView2(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel(), course: CourseModel(creatorID: "", teacher: "Teacher", title: "Current title", description: "This is the current example description multiline", imageURL: "https://plus.unsplash.com/premium_photo-1682417577134-61ea688729ff?q=80&w=3000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", category: "Swift", videosURL: ["video1url","video2url","video3url"]))
//}
