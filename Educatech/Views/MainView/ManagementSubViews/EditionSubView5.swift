//
//  EditionSubView5.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 27/11/23.
//

import SwiftUI

struct EditionSubView5: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @Binding var course: CourseModel
    @State var urlVideosToDelete: [String] = []
    @State var newValues = CreateCourseFormInputs()
    @State var hasError: Bool = false
    @Environment (\.colorScheme) var colorScheme
    @Environment (\.horizontalSizeClass) var horizontalSizeClass
    @Environment (\.verticalSizeClass) var verticalSizeClass
    
    
    var body: some View {
        NavigationStack {
            Text("Videos of the course")
                .font(.title)
                .bold()
                .padding()
            if verticalSizeClass == .regular{
                VStack {
                    CurrentVideosListEditViewComponent(authViewModel: authViewModel,
                                                       collectionsViewModel: collectionsViewModel,
                                                       course: $course,
                                                       urlVideosToDelete: $urlVideosToDelete,
                                                       hasError: $hasError)
                    .padding(.vertical)
                    AddVideosListEditViewComponent(authViewModel: authViewModel,
                                                   collectionsViewModel: collectionsViewModel,
                                                   newValues: $newValues,
                                                   hasError: $hasError)
                    .padding(.vertical)
                }
            }
            else {
                HStack {
                    Spacer()
                    CurrentVideosListEditViewComponent(authViewModel: authViewModel,
                                                       collectionsViewModel: collectionsViewModel,
                                                       course: $course,
                                                       urlVideosToDelete: $urlVideosToDelete,
                                                       hasError: $hasError)
                    Spacer()
                    AddVideosListEditViewComponent(authViewModel: authViewModel,
                                                   collectionsViewModel: collectionsViewModel,
                                                   newValues: $newValues,
                                                   hasError: $hasError)
                    Spacer()
                }
            }
            Spacer()
            Button {
                if newValues.selectedVideos == [] {
                    hasError = true
                    collectionsViewModel.allowContinue = false
                }
                else {
                    hasError = false
                    collectionsViewModel.allowContinue = true
                }
            } label: {
                ButtonViewComponent(title: "Add new videos selected", width: 250, foregroundColor: .gray.opacity(0.25), titleColor: .accentColor)
            }
            .padding(.bottom, 50)
            Spacer()
        }
    }
}

struct CurrentVideosListEditViewComponent: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @Binding var course: CourseModel
    @Binding var urlVideosToDelete: [String]
    @Binding var hasError: Bool
    @Environment (\.colorScheme) var colorScheme
    
    var body: some View {
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
                    Button("Update list of existing videos"){
                        print("update")
                    }
                }
                .padding(.horizontal)
        }
    }
}

struct AddVideosListEditViewComponent: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @Binding var newValues: CreateCourseFormInputs
    @Binding var hasError: Bool
    
    var body: some View {
        VStack {
            List {
                Section ("New videos to upload") {
                    ForEach(newValues.selectedVideos, id:\.self) { video in
                        Text(video.itemIdentifier ?? "0")
                            .lineLimit(1)
                            .swipeActions {
                                Button("Delete") {
                                    newValues.selectedVideos.removeAll { $0 == video }
                                }
                                .tint(Color.pink)
                            }
                    }
                }
            }
            .frame(maxWidth: 850)
            CoursesLoadVideoViewComponent(collectionsViewModel: collectionsViewModel, selectedVideos: $newValues.selectedVideos, label: "Select videos")
                .padding(.horizontal)
        }
    }
}

#Preview {
    EditionSubView5(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel(), course: .constant(CourseModel()))
}
