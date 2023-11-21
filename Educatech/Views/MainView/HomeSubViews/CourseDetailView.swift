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
    let course: CourseModel
    @State var showVideos: Bool = false
    @State var startCourseHasBeenTapped: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
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
                .frame(maxWidth: 1000)
                VStack (alignment: .leading, spacing: 20){
                    Text(course.title)
                        .font(.system(size: 30))
                        .fontWeight(.black)
                    Label(course.teacher, systemImage: "graduationcap")
                        .textCase(.uppercase)
                    Text(course.description)
                        .multilineTextAlignment(.leading)
                    HStack {
                        Spacer()
                        Label(course.category, systemImage: "book")
                        Label("\(course.numberOfStudents)", systemImage: "person")
                        Spacer()
                    }
                    .foregroundStyle(Color.gray)
                    .bold()
                }
                .frame(maxWidth: 1000)
                .padding(.horizontal, 20)
                
                if showVideos {
                    Text("Lista de videos")
                        .font(.title)
                        .bold()
                        .padding(.top,30)
                    VStack {
                        Rectangle()
                            .fill(Color.gray)
                            .frame(height: 1)
                        ForEach(Array(course.videosURL.enumerated()), id:\.1) { i, videoURL in
                            NavigationLink {
                                VideoPlayerView(videoTitle: "Lesson \(i + 1)", videoURL: videoURL)
                            } label: {
                                HStack {
                                    BlackScreenPlayViewComponent()
                                    Text("Lesson \(i + 1)")
                                        .padding(.horizontal, 20)
                                    Spacer()
                                }
                            }
                            .padding(.horizontal, 20)
                            .foregroundStyle(Color.gray)
                            .font(.title3)
                            .bold()
                            Rectangle()
                                .fill(Color.gray)
                                .frame(height: 1)
                        }
                    }
                    .frame(maxWidth: 1000)
                }
                else {
                    Button {
                        startCourseHasBeenTapped.toggle()
                    } label: {
                        Text("Start course")
                            .font(.system(size: 20))
                            .bold()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.accentColor)
                    .padding(50)
                }
            }
        }
        .onAppear {
            if let subscriptions = authViewModel.userData?.subscriptions {
                subscriptions.forEach { id in
                    if id == self.course.id {
                        self.showVideos = true
                    }
                }
            }
        }
        .alert(
            "You're about to start a new course! 🚀",
            isPresented: $startCourseHasBeenTapped,
            actions: {
                Button("Not ready..."){
                    print("Cancel")
                }
                .foregroundStyle(Color.pink)
                Button("Let's go!"){
                    authViewModel.addNewSubscription(newCourse: course, userData: authViewModel.userData ?? UserDataModel(email: "you@mail.com", username: "Anonymous"), collection: collectionsViewModel)
                    showVideos = true
                }
            },
            message: {
                Text("This is an exciting moment! There is no better place or time to learn something new than right here, right now!\n\nAre you ready?")
            })
    }
    func paintRating(_ number: Double) -> String {
        var result = ""
        let iterations = Int(number)
        
        if number == 0 {
            return "☆☆☆☆☆"
        }
        else if iterations > 0 && iterations < 5 {
            for _ in 1 ... iterations {
                result += "★"
            }
            for _ in 1 ... 5 - iterations {
                result += "☆"
            }
            return result
        }
        else {
            return "★★★★★"
        }
    }
}

#Preview {
    CourseDetailView(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel(), course: CourseModel(creatorID: "0", teacher: "Teacher", title: "Title", description: "Description", imageURL: "https://images.unsplash.com/photo-1590479773265-7464e5d48118?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",category: "Swift", videosURL: ["Video1", "Video2", "Video3"]))
}
