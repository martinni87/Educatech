//
//  CreationSubView4.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 7/11/23.
//

import SwiftUI
import PhotosUI

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
