//
//  EditionSubView2.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 21/11/23.
//

import SwiftUI
import PhotosUI

struct EditionSubView2: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @State var currentValues: CourseModel
    @State var newValues = CreateCourseFormInputs()
    @Environment (\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            HeaderViewComponent(headerModel: HeaderModel(headerType: .editCourse), frameSize: 50)
            List {
                Section("Title") {
                    Text("\(currentValues.title)").bold().foregroundStyle(Color.gray)
                    TextField("Change value", text: $newValues.title)
                }
                Section("Description") {
                    Text("\(currentValues.description)").bold().foregroundStyle(Color.gray)
                    TextField("Change value", text: $newValues.description)
                }
                Section("Category") {
                    Text("\(currentValues.category)").bold().foregroundStyle(Color.gray)
                    PickerViewComponent(label: "New category", variable: $newValues.category)
                }
                Section("Picture"){
                    HStack {
                        AsyncImage(url: URL(string: currentValues.imageURL)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 80)
                                    .clipShape(.rect(cornerRadius: 5))
                            }
                        }
                        Text("➤").font(.largeTitle).foregroundStyle(Color.gray)
                        if newValues.selectedPicture == nil {
                            Text("No changes")
                        }
                        else {
                            Text(newValues.selectedPicture?.itemIdentifier ?? "No id")
                        }
                    }
                    GalleryPhotoViewComponent(collectionsViewModel: collectionsViewModel, selectedPicture: $newValues.selectedPicture)
                }
                Section("Videos") {
                    Text("Old").bold().font(.callout).foregroundStyle(Color.gray)
                    ForEach(Array(currentValues.videosURL.enumerated()), id:\.1) { i, video in
                        HStack {
                            Text("Lesson \(i+1): \(video)").lineLimit(1)
                                .swipeActions {
                                    Button("Delete"){
                                        currentValues.videosURL.removeAll { $0 == video }
                                    }
                                    .tint(Color.pink)
                                }
                        }
                    }
                    Text("New").bold().font(.callout).foregroundStyle(Color.gray)
                    ForEach(newValues.selectedVideos, id:\.self) { video in
                        Text(video.itemIdentifier ?? "")
                            .lineLimit(1)
                    }
                    GalleryVideoViewComponent(collectionsViewModel: collectionsViewModel, selectedVideos: $newValues.selectedVideos)
                }
            }
            .frame(maxWidth: 1000)
            Button("Submit changes") {
                print("Submit changes")
            }
            .bold()
        }
    }
}

#Preview {
    EditionSubView2(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel(), currentValues: CourseModel(creatorID: "", teacher: "Teacher", title: "Current title", description: "This is the current example description multiline", imageURL: "https://plus.unsplash.com/premium_photo-1682417577134-61ea688729ff?q=80&w=3000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", category: "Swift", videosURL: ["video1url","video2url","video3url"]))
}
