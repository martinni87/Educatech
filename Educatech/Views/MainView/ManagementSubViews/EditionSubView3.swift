//
//  EditionSubView3.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 27/11/23.
//

import SwiftUI

/// The third step in the course editing process.
///
/// This view allows the user to modify the title, description, and category of the selected course.
///
/// - Parameters:
///   - authViewModel: An observed object representing the authentication view model.
///   - collectionsViewModel: An observed object representing the collections view model.
///   - course: A state variable representing the course to be edited.
struct EditionSubView3: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @State var course: CourseModel
    @State var newValues = CreateCourseFormInputs()
    @State var changeInfoAlert: Bool = false
    @State var goHomeAlert: Bool = false
    @State var goHome: Bool = false
    
    @Environment (\.colorScheme) var colorScheme
    @Environment (\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        NavigationStack {
            Text("Course info")
                .font(.title)
                .bold()
            Spacer()
            VStack (alignment: .leading) {
                Text("Title: ").bold() + Text(course.title).font(.callout).foregroundStyle(Color.gray).bold()
                CoursesTextFieldViewComponent(collectionsViewModel: collectionsViewModel, variable: $newValues.title, errorMsg: collectionsViewModel.titleErrorMsg, label: "", placeholder: "New title", tooltip: "Write a new title for your course. Changes won't take place until you 'Submit changes'. Leave blank to keep current value.")
                    .onTapGesture {
                        collectionsViewModel.categoryErrorMsg = nil
                        if collectionsViewModel.allowContinue {
                            collectionsViewModel.allowContinue.toggle()
                        }
                    }
                    .onChange(of: newValues.title) { _, _ in
                        self.collectionsViewModel.allowContinue = false
                    }
                
                VStack (alignment: .leading) {
                    Text("Description: ").bold() + Text(course.description).font(.callout).foregroundStyle(Color.gray).bold()
                    Rectangle()
                        .fill(colorScheme == .light ? .black.opacity(0.1) : .white.opacity(0.1))
                        .frame(minHeight: 40)
                        .frame(maxHeight: 100)
                        .frame(maxWidth: 850)
                        .cornerRadius(10)
                        .overlay {
                            HStack {
                                TextField("New description", text: $newValues.description, axis: .vertical)
                                    .padding(.horizontal)
                                    .foregroundStyle(Color.accentColor)
                                    .textFieldStyle(.plain)
                                    .textInputAutocapitalization(.never)
                                    .onTapGesture {
                                        collectionsViewModel.cleanCollectionsCache()
                                    }
                            }
                        }
                    Text("Write a new description for your course. Changes won't take place until you 'Submit changes'. Leave blank to keep current value.").font(.caption).bold().foregroundStyle(Color.gray)
                }
                .padding(.bottom)
                
                Text("Category: ").bold() + Text(course.category).font(.callout).foregroundStyle(Color.gray).bold()
                PickerViewComponent(label: "Category", variable: $newValues.category)
            }
            Spacer()
            if verticalSizeClass != .compact {
                Text("Good to go!")
                    .foregroundStyle(collectionsViewModel.allowContinue ? Color.accentColor : Color.clear)
                Spacer()
            }
            HStack {
                if verticalSizeClass == .compact {
                    Text("Good to go!")
                        .foregroundStyle(collectionsViewModel.allowContinue ? Color.accentColor : Color.clear)
                        .padding(.horizontal)
                }
                if collectionsViewModel.allowContinue {
                    Button {
                        changeInfoAlert.toggle()
                    } label: {
                        ButtonViewComponent(title: "Submit changes", foregroundColor: .gray.opacity(0.1), titleColor: .accentColor)
                    }
                }
                else {
                    Button {
                        if newValues.title != "" {
                            collectionsViewModel.validateTitleInEditionForm(newValues)
                        }
                        else {
                            collectionsViewModel.allowContinue = true
                        }
                    } label: {
                        ButtonViewComponent(title: "Check fields", foregroundColor: .gray.opacity(0.1), titleColor: .accentColor)
                    }
                    .disabled(newValues.title == "" && newValues.description == "" && newValues.category == "")
                }
                Button {
                    collectionsViewModel.cleanCollectionsCache()
                    newValues = CreateCourseFormInputs()
                } label: {
                    ButtonViewComponent(title: "Reset form", foregroundColor: .gray.opacity(0.1), titleColor: (newValues.title == "" && newValues.description == "" && newValues.category == "") ? .gray : .pink.opacity(0.5))
                }
                .disabled(newValues.title == "" && newValues.description == "" && newValues.category == "")
            }
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing, content: {
                HStack {
                    NavigationLink {
                        EditionSubView4(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel, course: $course)
                    } label: {
                        Label("Edit picture", systemImage: "photo.badge.plus").bold()
                    }
                    NavigationLink {
                        EditionSubView5(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel, course: $course)
                    } label: {
                        Label("Edit videos", systemImage: "video.badge.plus").bold()
                    }
                    Button("Go Home"){
                        self.goHomeAlert.toggle()
                    }
                }
            })
        }
        .onChange(of: collectionsViewModel.singleCourse) { _, newValue in
            course = newValue
        }
        //In case user wants to submit changes
        .alert("Change info of course.",isPresented: $changeInfoAlert) {
            Button("Yes. Proceed."){
                collectionsViewModel.editCourseData(
                    changeTo: CourseModel(id: course.id ?? "0",
                                          creatorID: course.creatorID,
                                          teacher: course.teacher,
                                          title: newValues.title != "" ? newValues.title : course.title,
                                          description: newValues.description != "" ? newValues.description : course.description,
                                          imageURL: course.imageURL,
                                          category: newValues.category != "" ? newValues.category : course.category,
                                          videosURL: course.videosURL,
                                          numberOfStudents: course.numberOfStudents,
                                          approved: course.approved))
                newValues = CreateCourseFormInputs()
                collectionsViewModel.allowContinue = false
            }
            Button("No. Cancel."){
                print("Modifications cancelled")
            }
        } message: {
            Text("Are you sure? You're about to make some changes in your course information. This action cannot be undone.")
        }
        //In case user wants to quit
        .alert("Go to Homescreen?", isPresented: $goHomeAlert) {
            Button("Yes"){
                goHome.toggle()
            }
            Button("No") {}
        } message: {
            Text("Are you sure you want to quit editing? All unsaved changes will be lost")
        }
        //If user validates exit
        .fullScreenCover(isPresented: $goHome) {
            MainView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
        }
        .frame(maxWidth: 850)
        .padding()
    }
}

#Preview {
    EditionSubView3(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel(), course: (CourseModel(creatorID: "", teacher: "", title: "Example title", description: "A not so long example description of a course", imageURL: "No picture", category: "Swift")))
}
