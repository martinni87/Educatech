//
//  EditionSubView5.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 27/11/23.
//

import SwiftUI
import PhotosUI

struct EditionSubView5: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @Binding var course: CourseModel
    
    @State var newVideosList: [PhotosPickerItem] = []
    @State var urlVideosToDelete: [String] = []
    @State var urlVideosRemaining: [String] = []
    @State var deletionAlert: Bool = false
    @State var addNewAlert: Bool = false
    @State var performDeletion: Bool = false
    @State var performAddition: Bool = false
    @State var emptyListAlert: Bool = false
    
    @Environment (\.colorScheme) var colorScheme
    @Environment (\.horizontalSizeClass) var horizontalSizeClass
    @Environment (\.verticalSizeClass) var verticalSizeClass
    @Environment (\.dismiss) var dismiss
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Text("Videos of the course")
                        .font(.title)
                        .bold()
                        .padding()
                    if verticalSizeClass == .regular{
                        VStack {
                            CurrentVideosListEditViewComponent(
                                authViewModel: authViewModel,
                                collectionsViewModel: collectionsViewModel,
                                course: $course,
                                urlVideosToDelete: $urlVideosToDelete,
                                urlVideosRemaining: $urlVideosRemaining,
                                deletionAlert: $deletionAlert)
                            .padding(.vertical)
                            AddVideosListEditViewComponent(
                                authViewModel: authViewModel,
                                collectionsViewModel: collectionsViewModel,
                                newVideosList: $newVideosList,
                                addNewAlert: $addNewAlert)
                            .padding(.vertical)
                        }
                    }
                    else {
                        HStack {
                            Spacer()
                            CurrentVideosListEditViewComponent(
                                authViewModel: authViewModel,
                                collectionsViewModel: collectionsViewModel,
                                course: $course,
                                urlVideosToDelete: $urlVideosToDelete,
                                urlVideosRemaining: $urlVideosRemaining,
                                deletionAlert: $deletionAlert)
                            Spacer()
                            AddVideosListEditViewComponent(
                                authViewModel: authViewModel,
                                collectionsViewModel: collectionsViewModel,
                                newVideosList: $newVideosList,
                                addNewAlert: $addNewAlert)
                            Spacer()
                        }
                    }
                }
                .onChange(of: collectionsViewModel.singleCourse) { _, courseUpToDate in
                    //In case course updated, clean all variables
                    course = courseUpToDate
                    newVideosList = []
                    urlVideosToDelete = []
                    urlVideosRemaining = []
                    deletionAlert = false
                    addNewAlert = false
                    performDeletion = false
                    performAddition = false
                }
                .disabled(performDeletion || performAddition)
                if performDeletion {
                    WaitingViewComponent()
                        .onAppear {
                            StorageManager().deleteStorageByURL(
                                course: CourseModel(id: course.id!,
                                                    creatorID: course.creatorID,
                                                    teacher: course.teacher,
                                                    title: course.title,
                                                    description: course.description,
                                                    imageURL: course.imageURL,
                                                    category: course.category,
                                                    videosURL: urlVideosRemaining,
                                                    numberOfStudents: course.numberOfStudents,
                                                    approved: course.approved),
                                urlStringList: urlVideosToDelete,
                                collection: collectionsViewModel)
                        }
                }
                if performAddition {
                    WaitingViewComponent()
                        .onAppear {
                            collectionsViewModel.addNewVideoListToCourse(course: course,
                                                                         newVideosList: newVideosList)
                        }
                }
            }
            //Alert shown in case user wants to delete videos of server
            .alert("Delete a video", isPresented: $deletionAlert, actions: {
                Button("Yes"){
                    performDeletion.toggle()
                }
                Button("No") {
                    print("Deletion of videos has been cancelled")
                }
            }, message: {
                Text("Do you want to delete the selected items?")
            })
            //Alert shown in case user wants to add new videos to the server
            .alert("Add new videos", isPresented: $addNewAlert, actions: {
                Button("Yes"){
                    performAddition.toggle()
                }
                Button("No") {
                    print("Add new videos has been cancelled")
                }
            }, message: {
                Text("Do you want to add the selected items?")
            })
            //Alert in case user wants to leave without any course at server
            .alert("Are you sure you want to leave?", isPresented: $emptyListAlert, actions: {
                Button("Just leave"){
                    print("User leaves")
                    dismiss()
                }
                Button("Ok, let's add videos") {
                    print("User stays")
                }
            }, message: {
                Text("You don't have any video available for this course. Do you really want to leave? An Admin might switch your approval status to not approved. Please consider adding a new video.")
            })
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        if course.videosURL.isEmpty {
                            emptyListAlert.toggle()
                        }
                        else {
                            dismiss()
                        }
                    } label: {
                        Label("Go back", systemImage: "chevron.left")
                    }
                }
            }
        }
    }
}

struct CurrentVideosListEditViewComponent: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @Binding var course: CourseModel
    @Binding var urlVideosToDelete: [String]
    @Binding var urlVideosRemaining: [String]
    @Binding var deletionAlert: Bool
    @Environment (\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    Section {
                        ForEach(course.videosURL, id:\.self) { video in
                            Text(video)
                                .lineLimit(1)
                                .foregroundStyle(urlVideosToDelete.contains(video) ? .pink : .accentColor)
                                .swipeActions {
                                    if !urlVideosToDelete.contains(video) {
                                        Button("Mark to delete") {
                                            urlVideosToDelete.append(video)
                                            print("Marked to delete: \(urlVideosToDelete)")
                                        }
                                        .tint(Color.pink)
                                    }
                                    else {
                                        Button("Recover") {
                                            urlVideosToDelete.removeAll { $0 == video }
                                            print("Marked to delete: \(urlVideosToDelete)")
                                        }
                                        .tint(Color.accentColor)
                                    }
                                }
                        }
                    } header: {
                        Text("Current list of videos")
                    } footer: {
                        Text("Swipe left each row to mark to delete or unmark and keep it. Changes won't take place until you submit them. One submitted, the action cannot be undone and unsaved data will be lost.")
                    }
                }
                .frame(maxWidth: 850)
                Spacer()
                Rectangle()
                    .fill(colorScheme == .light ? .black.opacity(0.1) : .white.opacity(0.1))
                    .frame(height: 40)
                    .frame(maxWidth: 850)
                    .cornerRadius(10)
                    .overlay {
                        Button("Delete selected videos"){
                            self.urlVideosRemaining = course.videosURL.filter { !urlVideosToDelete.contains($0)
                            }
                            deletionAlert.toggle()
                        }
                        .disabled(course.videosURL.isEmpty || urlVideosToDelete.isEmpty)
                    }
                    .padding(.horizontal)
            }
        }
    }
}

struct AddVideosListEditViewComponent: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @Binding var newVideosList: [PhotosPickerItem]
    @Binding var addNewAlert: Bool
    
    var body: some View {
        VStack {
            List {
                Section {
                    ForEach(newVideosList, id:\.self) { video in
                        Text(video.itemIdentifier ?? "0")
                            .lineLimit(1)
                            .swipeActions {
                                Button("Remove") {
                                    newVideosList.removeAll { $0 == video }
                                }
                                .tint(Color.pink)
                            }
                    }
                } header: {
                    Text("New videos to upload")
                } footer: {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Swipe left in each row to remove a video. Changes won't take place until you submit them.")
                        Text("You must have at least one video uploaded in the server.").bold()
                    }
                }
            }
            .frame(maxWidth: 850)
            if newVideosList.isEmpty {
                CoursesLoadVideoViewComponent(collectionsViewModel: collectionsViewModel, selectedVideos: $newVideosList, label: "Select videos")
                    .padding(.horizontal)
            }
            else {
                Button {
                    addNewAlert.toggle()
                } label: {
                    ButtonViewComponent(title: "Upload new videos", width: 250, foregroundColor: .gray.opacity(0.1), titleColor: .accentColor)
                }
            }
        }
    }
}

#Preview {
    EditionSubView5(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel(), course: .constant(CourseModel()))
}
