//
//  ManagedCourseDetailView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 7/10/23.
//

import SwiftUI

struct ManagedCourseDetailView: View {
    
    @Binding var course: CourseModel
    @State var title = ""
    @State var image = ""
    @State var description = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Course information") {
                    Group { Text("ID: ").bold() + Text(course.id ?? "No id") } .foregroundColor(.gray)
                    Group { Text("Creator ID: ").bold() + Text(course.creatorID) } .foregroundColor(.gray)
                    HStack {
                        Text("Title: ").bold()
                        TextField("Title", text: $title)
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text("Image URL: ").bold()
                        TextField("Image", text: $image)
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.gray)
                    }
                    HStack {
                        VStack (alignment: .leading) {
                            Text("Description: ").bold()
                            TextEditor(text: $description)
                                .frame(minHeight: 50)
                        }
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.gray)
                    }
                }
                .onAppear {
                    title =  course.title
                    image  = course.image
                    description = course.description
                }
                Section("Multimedia") {
                    NavigationLink {
                        AddNewVideosView()
                    } label: {
                        Text("Add new videos")
                            .foregroundStyle(Color.blue)
                    }
                }
                .navigationTitle("Editing: \(course.id!)")
            }
            HStack {
                Spacer()
                Button("Save changes"){
                    print("Save changes")
                }
                .tint(.green)
                .bold()
                Spacer()
                Button("Delete course"){
                    print("Delete course")
                }
                .tint(.pink)
                Spacer()
            }
        }
    }
}

struct ManagedCourseDetailView_Previews: PreviewProvider {
    
    @State static var course: CourseModel = CourseModel(id: "1234567890", title: "Dummy title", description: "Dummy description of a course very long to test multiline capabilities", image: "https://wwww.image.com/image.jpeg", creatorID: "cid9999")
    
    static var previews: some View {
        ManagedCourseDetailView(course: $course, title: "")
    }
}
