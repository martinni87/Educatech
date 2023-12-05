//
//  ContentView.swift
//  Educatech-admin
//
//  Created by Martín Antonio Córdoba Getar on 29/11/23.
//

import SwiftUI

enum ActiveView {
    case usersManagement, coursesManagement
}

struct ContentView: View {
    
    @ObservedObject var collections: CollectionsViewModel
    @State var activeView: ActiveView = .usersManagement
    @State var pageTitle: String = ""
    
    var body: some View {
        NavigationView {
            SideMenu(activeView: $activeView)
            List {
                switch activeView {
                case .usersManagement:
                    UsersManagementView(collections: collections)
                        .onAppear {
                            pageTitle = "Users management"
                        }
                case .coursesManagement:
                    CoursesManagementView(collections: collections)
                        .onAppear {
                            pageTitle = "Courses management"
                        }
                }
            }
            .navigationTitle(pageTitle)
        }
    }
}



struct SideMenu: View {
    
    @Binding var activeView: ActiveView
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Educatech Admin Center")
                .padding()
                .font(.largeTitle)
                .fontWeight(.black)
            
            VStack (alignment: .leading, spacing: 10) {
                Button {
                    activeView = .usersManagement
                } label: {
                    Rectangle().fill(Color.gray.opacity(0.1)).frame(height: 50).clipShape(.buttonBorder).overlay {
                        HStack {
                            Text("Managed users")
                                .padding()
                            Spacer()
                        }
                    }
                }
                Button {
                    activeView = .coursesManagement
                } label: {
                    Rectangle().fill(Color.gray.opacity(0.1)).frame(height: 50).clipShape(.buttonBorder).overlay {
                        HStack {
                            Text("Managed courses")
                                .padding()
                            Spacer()
                        }
                    }
                }
            }
            .bold()
            .padding(.vertical, 50)
            Spacer()
        }
    }
}

struct UsersManagementView: View {
    
    @ObservedObject var collections: CollectionsViewModel
    
    var body: some View {
        VStack {
            ForEach(collections.allUsers, id:\.id) { user in
                HStack {
                    VStack (alignment: .leading) {
                        Text("UUID: \(user.id!)").bold()
                        Text("Email: \(user.email)")
                        Text("Username: \(user.username)")
                    }
                    .padding()
                    Spacer()
                    Toggle(isOn: .constant(user.isEditor)) {
                        HStack{
                            Spacer()
                            Text("Editor status: \(user.isEditor ? "Active" : "Not active")")
                        }
                    }
                    .onTapGesture {
                        let isEditor = !user.isEditor
                        collections.editUserData(
                            changeTo: UserDataModel(id: user.id!,
                                                    email: user.email,
                                                    username: user.username,
                                                    isEditor: isEditor,
                                                    categories: user.categories,
                                                    contentCreated: user.contentCreated,
                                                    subscriptions: user.subscriptions))
                    }
                }
            }
        }
    }
}

struct CoursesManagementView: View {
    
    @ObservedObject var collections: CollectionsViewModel
    
    var body: some View {
        VStack {
            ForEach(collections.allCourses, id:\.id) { course in
                HStack {
                    VStack (alignment: .leading) {
                        Text("UUID: \(course.id!)").bold()
                        Text("Creator ID: \(course.creatorID)")
                        Text("Title: \(course.title)")
                        Text("Category: \(course.category)")
                    }
                    .padding()
                    Spacer()
                    Toggle(isOn: .constant(course.approved)) {
                        HStack{
                            Spacer()
                            Text("Course status: \(course.approved ? "Validated" : "Not validated")")
                        }
                    }
                    .onTapGesture {
                        let status = !course.approved
                        collections.editCourseData(
                            changeTo: CourseModel(id: course.id!,
                                                  creatorID: course.creatorID,
                                                  teacher: course.teacher,
                                                  title: course.title,
                                                  description: course.description,
                                                  imageURL: course.imageURL,
                                                  category: course.category,
                                                  videosURL: course.videosURL,
                                                  numberOfStudents: course.numberOfStudents,
                                                  approved: status))
                    }
                }
            }
        }
    }
}

#Preview {
    CoursesManagementView(collections: CollectionsViewModel())
}

#Preview {
    ContentView(collections: CollectionsViewModel())
}

#Preview {
    UsersManagementView(collections: CollectionsViewModel())
}
