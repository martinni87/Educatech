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
    @State var courseToUnsubscribe: CourseModel = CourseModel()
    @State var isSubscribed: Bool = false
    @State var startCourseHasBeenTapped: Bool = false
    @State var unsubscribeWarning: Bool = false
    @State var goToHome: Bool = false
    @Environment (\.horizontalSizeClass) var horizontalSizeClass
    @Environment (\.verticalSizeClass) var verticalSizeClass
    @Environment (\.dismiss) var dismiss

    
    var body: some View {
        NavigationStack {
            ScrollView {
                AsyncImageViewComponent(course: $course)
                    .scaledToFill()
                    .frame(maxHeight: verticalSizeClass == .compact ? 250 : 425)
                    .frame(maxWidth: 850)
                    .clipShape(.rect(cornerRadius: horizontalSizeClass == .compact ? 0 : 10))
                    .clipped()
                VStack (alignment: .leading, spacing: 20){
                    Text(course.title)
                        .font(.system(size: 30))
                        .fontWeight(.black)
                    Label(course.teacher, systemImage: "graduationcap.fill")
                        .textCase(.uppercase)
                        .fontWeight(.black)
                    Text(course.description)
                        .multilineTextAlignment(.leading)
                    HStack {
                        Spacer()
                        Label(course.category, systemImage: "book.fill")
                        Label("\(course.numberOfStudents)", systemImage: "person.fill")
                        Spacer()
                    }
                    .foregroundStyle(Color.accentColor)
                    .bold()
                }
                .frame(maxWidth: 850)
                .padding(.horizontal, 30)
                
                if isSubscribed {
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
                        Rectangle()
                            .fill(Color.accentColor)
                            .frame(height: 1)
                        Button("Unsubscribe") {
                            self.courseToUnsubscribe = self.course
                            unsubscribeWarning.toggle()
                        }
                        .foregroundStyle(Color.pink)
                    }
                    .frame(maxWidth: 850)
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
            // Check if user is subscribed to this course
            if let subscriptions = authViewModel.userData?.subscriptions {
                subscriptions.forEach { id in
                    if id == self.course.id {
                        self.isSubscribed = true
                    }
                }
            }
        }
        .onChange(of: collectionsViewModel.subscribedCourses, { _, _ in
            collectionsViewModel.subscribedCourses.forEach { courseUpdate in
                if self.course.id == courseUpdate.id {
                    self.course = courseUpdate
                    return
                }
            }
        })
        //Info: let know the user that is going to start a new course (YES/NO)
        .alert(
            "You're about to start a new course! 🚀",
            isPresented: $startCourseHasBeenTapped,
            actions: {
                Button("Not ready..."){
                    print("Cancel")
                }
                .foregroundStyle(Color.pink)
                Button("Let's go!"){
                    if let userData = authViewModel.userData, let courseID = course.id {
                        var subscriptions = userData.subscriptions
                        subscriptions.append(courseID)
                        authViewModel.editUserData(
                            changeTo: UserDataModel(id: userData.id,
                                                    email: userData.email,
                                                    username: userData.username,
                                                    isEditor: userData.isEditor,
                                                    categories: userData.categories,
                                                    contentCreated: userData.contentCreated,
                                                    subscriptions: subscriptions))
                        collectionsViewModel.editCourseData(
                            changeTo: CourseModel(id: courseID,
                                                  creatorID: course.creatorID,
                                                  teacher: course.teacher,
                                                  title: course.title,
                                                  description: course.description,
                                                  imageURL: course.imageURL,
                                                  category: course.category,
                                                  videosURL: course.videosURL,
                                                  numberOfStudents: course.numberOfStudents + 1,
                                                  approved: course.approved))
                        collectionsViewModel.getSubscribedCoursesByID(coursesIDs: subscriptions)
                    }
                    isSubscribed = true
                }
            },
            message: {
                Text("This is an exciting moment! There is no better place or time to learn something new than right here, right now!\n\nAre you ready?")
            })
        //Alert in case user wants to delete a subscription
        .alert("Are you sure?", isPresented: $unsubscribeWarning) {
            Button("Yes. Proceed") {
                if let userData = authViewModel.userData {
                    var subscriptions = userData.subscriptions
                    let course = self.courseToUnsubscribe
                    subscriptions.removeAll { $0 == self.courseToUnsubscribe.id }
                    authViewModel.editUserData(
                        changeTo: UserDataModel(id: userData.id,
                                                email: userData.email,
                                                username: userData.username,
                                                isEditor: userData.isEditor,
                                                categories: userData.categories,
                                                contentCreated: userData.contentCreated,
                                                subscriptions: subscriptions))
                    collectionsViewModel.editCourseData(
                        changeTo: CourseModel(id: course.id,
                                              creatorID: course.creatorID,
                                              teacher: course.teacher,
                                              title: course.title,
                                              description: course.description,
                                              imageURL: course.imageURL,
                                              category: course.category,
                                              videosURL: course.videosURL,
                                              numberOfStudents: course.numberOfStudents - 1,
                                              approved: course.approved))
                    collectionsViewModel.getSubscribedCoursesByID(coursesIDs: subscriptions)
                    self.courseToUnsubscribe = CourseModel()
                    self.goToHome = true
                }
            }
            Button("No. Cancel") {
                self.courseToUnsubscribe = CourseModel()
            }
        } message: {
            Text("Are you sure you want to unsubscribe to the course?")
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    if let userData = authViewModel.userData {
                        var subscriptions = userData.subscriptions
                        collectionsViewModel.getSubscribedCoursesByID(coursesIDs: subscriptions)
                        collectionsViewModel.getAllCourses()
                        dismiss()
                    }
                } label: {
                    Label("Go back", systemImage: "chevron.left")
                        .labelStyle(.titleAndIcon)
                }
            }
        }
        .fullScreenCover(isPresented: $goToHome) {
            MainView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
        }
    }
}

#Preview {
    CourseDetailView(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel(), course: CourseModel(creatorID: "0", teacher: "Teacher", title: "Title", description: "Description", imageURL: "https://images.unsplash.com/photo-1590479773265-7464e5d48118?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",category: "Swift", videosURL: ["Video1", "Video2", "Video3"]))
}
