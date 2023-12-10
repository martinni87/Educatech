//
//  CreationSubView4.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 7/11/23.
//

import SwiftUI
import PhotosUI

/// A subview for creating a new course - step 4.
///
/// This view is part of the course creation process. It includes a header, a video selection component, a list of loaded videos, and navigation links.
///
/// - Parameters:
///   - authViewModel: An observed object representing the authentication view model.
///   - collectionsViewModel: An observed object representing the collections view model.
///   - formInputs: A binding to the form inputs for creating a course.
struct CreationSubView4: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @Binding var formInputs: CreateCourseFormInputs
    @State var hasError: Bool = false
    
    var body: some View {
        NavigationStack {
            HeaderViewComponent(headerModel: HeaderModel(headerType: .createcourse4), frameSize: 70)
            CoursesLoadVideoViewComponent(collectionsViewModel: collectionsViewModel, selectedVideos: $formInputs.selectedVideos, label: "Select videos")
                .padding()
            List {
                Section ("Loaded videos") {
                    ForEach(formInputs.selectedVideos, id:\.self) { video in
                        Text(video.itemIdentifier ?? "")
                            .lineLimit(1)
                            .swipeActions {
                                Button("Delete") {
                                    formInputs.selectedVideos.removeAll { $0 == video }
                                }
                                .tint(Color.pink)
                            }
                    }
                }
            }
            .frame(maxWidth: 850)
            Spacer()
            if collectionsViewModel.allowContinue {
                Text("Good to go!")
                    .foregroundStyle(Color.accentColor)
            }
            else if hasError {
                Text("You need to upload at least one video")
                    .foregroundStyle(Color.pink)
            }
            else {
                Text("Clear text to reserve space")
                    .foregroundStyle(Color.clear)
            }
            Spacer()
            if collectionsViewModel.allowContinue {
                NavigationLink {
                    CreationSubView5(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel, formInputs: $formInputs)
                } label: {
                    ButtonViewComponent(title: "Next", foregroundColor: .gray.opacity(0.1), titleColor: .accentColor)
                }
            }
            else {
                Button {
                    if formInputs.selectedVideos == [] {
                        hasError = true
                        collectionsViewModel.allowContinue = false
                    }
                    else {
                        hasError = false
                        collectionsViewModel.allowContinue = true
                    }
                } label: {
                    ButtonViewComponent(title: "Check fields", foregroundColor: .gray.opacity(0.1), titleColor: .accentColor)
                }
                .padding(.bottom, 50)
            }
            Spacer()
        }
    }
}

#Preview {
    CreationSubView4(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel(), formInputs: .constant(CreateCourseFormInputs()))
}
