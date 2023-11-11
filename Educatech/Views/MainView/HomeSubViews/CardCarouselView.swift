//
//  CardCarouselView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 10/11/23.
//

import SwiftUI

struct CardCarouselView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    let coursesPresented: [CourseModel]
    let sectionTitle: String
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(sectionTitle)
                .font(.largeTitle)
                .bold()
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(coursesPresented, id: \.id) { course in
                        NavigationLink {
                            CourseDetailView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel, course: course, showVideos: false)
                        } label: {
                            CardView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel, course: course)
                        }
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .padding()
        }
    }
}

#Preview {
    CardCarouselView(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel(), coursesPresented: [CourseModel(creatorID: "0", teacher: "Teacher", title: "Title", description: "Description", imageURL: "")], sectionTitle: "All courses")
}
