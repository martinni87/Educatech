//
//  CourseDetailView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 22/9/23.
//

import SwiftUI

struct CourseDetailView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @State var course: CourseModel
    @State var showVideos: Bool = false
    
    var body: some View {
        NavigationStack {
            AsyncImage(url: URL(string: course.imageURL)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                }
                else {
                    WaitingAnimationViewComponent()
                }
            }
            VStack (alignment: .leading, spacing: 20){
                Text(course.title)
                    .font(.system(size: 30))
                    .fontWeight(.black)
                Text(course.description)
                    .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, 10)
            
            if !showVideos {
                Button {
                    showVideos.toggle()
                } label: {
                    Text("Start course")
                        .font(.system(size: 20))
                        .bold()
                }
                .buttonStyle(.borderedProminent)
                .tint(.accentColor)
                .padding(50)
            }
            else {
                Text("Lista de videos")
                    .font(.title)
                    .bold()
                    .padding(.top,30)
                List {
                    ForEach(Array(course.videosURL.enumerated()), id:\.1) { i, videoURL in
                        NavigationLink ("Lesson \(i)"){
                            VideoPlayerView(videoTitle: "Lesson \(i)", videoURL: videoURL)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CourseDetailView(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel(), course: CourseModel(creatorID: "0", teacher: "Teacher", title: "Title", description: "Description", imageURL: "https://images.unsplash.com/photo-1590479773265-7464e5d48118?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",category: "Swift", videosURL: ["Video1", "Video2", "Video3"]))
}
