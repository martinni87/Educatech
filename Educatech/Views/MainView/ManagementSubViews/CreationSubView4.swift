//
//  CreationSubView4.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 7/11/23.
//

import SwiftUI

struct CreationSubView4: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @Binding var formInputs: CreateCourseFormInputs
    
    var body: some View {
        NavigationStack {
            HeaderViewComponent(headerModel: HeaderModel(headerType: .createcourse4), frameSize: 70)
            CoursesLoadVideoViewComponent(collectionsViewModel: collectionsViewModel, selectedVideos: $formInputs.selectedVideos, label: "Select videos")
                .padding()
//            AddVideoViewComponent(formInputs: $formInputs)
//                .padding()
            List {
                Section ("Loaded videos") {
                    ForEach(formInputs.selectedVideos, id:\.self) { video in
                        Text(video.itemIdentifier ?? "")
                            .lineLimit(1)
                    }
                }
            }
            Spacer()
            NavigationLink {
                CreationSubView5(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel, formInputs: $formInputs)
            } label: {
                ButtonViewComponent(title: "Next", foregroundColor: .gray.opacity(0.3), titleColor: .accentColor)
            }
            .padding()
        }
    }
}

#Preview {
    CreationSubView4(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel(), formInputs: .constant(CreateCourseFormInputs()))
}
