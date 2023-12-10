//
//  CourseInfoSectionViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 27/11/23.
//

import SwiftUI

/**
 A SwiftUI view component representing a section for displaying and editing course information.

 - Note: This component includes fields for the current title, description, and category, as well as text input and a picker for making changes.
 - Parameters:
   - collectionsViewModel: The view model managing collections.
   - course: Binding to the current course model.
   - newValues: Binding to the form inputs for creating/editing a course.
   - changeInfoAlert: Binding to indicate whether to show an alert for changing course information.
   - noChangesAlert: Binding to indicate whether to show an alert for no changes made.
 */
struct CourseInfoSectionViewComponent: View {
    
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @Binding var course: CourseModel
    @Binding var newValues:CreateCourseFormInputs
    @Binding var changeInfoAlert: Bool
    @Binding var noChangesAlert: Bool
    
    @Environment (\.colorScheme) var colorScheme
    
    var body: some View {
        List {
            Text("Current title: ")
                .foregroundStyle(Color.gray)
                .bold() +
            Text(course.title)
                .foregroundStyle(Color.gray)
            Rectangle()
                .fill(colorScheme == .light ? .black.opacity(0.1) : .white.opacity(0.1))
                .fill(collectionsViewModel.titleErrorMsg != nil ? .pink.opacity(0.1) : .clear)
                .frame(height: 40)
                .frame(maxWidth: 850)
                .cornerRadius(10)
                .overlay {
                    TextField("New title", text: $newValues.title)
                        .foregroundStyle(Color.accentColor)
                        .padding()
                }
            Text("Current description: ")                        .foregroundStyle(Color.gray)
                .bold() +
            Text(course.description)
                .foregroundStyle(Color.gray)
            Rectangle()
                .fill(colorScheme == .light ? .black.opacity(0.1) : .white.opacity(0.1))
                .fill(collectionsViewModel.descriptionErrorMsg != nil ? .pink.opacity(0.1) : .clear)
                .frame(height: 100)
                .frame(maxWidth: 850)
                .cornerRadius(10)
                .overlay {
                    TextEditor(text: $newValues.description)
                        .foregroundStyle(Color.accentColor)
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                        .frame(height: 100)
                }
            HStack {
                Text("Current category: ")
                    .foregroundStyle(Color.gray)
                Text(course.category)
                    .foregroundStyle(Color.gray)
                    .bold()
            }
            PickerViewComponent(label: "New category", variable: $newValues.category, useCase: .userCategory)
        }
        HStack {
            Spacer()
            Button("Submit info changes") {
                if newValues.title == "" && newValues.description == "" && newValues.category == "" {
                    noChangesAlert.toggle()
                }
                else {
                    changeInfoAlert.toggle()
                }
            }
            .bold()
            Spacer()
            Button("Reset info") {
                newValues.title = ""
                newValues.description = ""
                newValues.category = ""
            }
            .bold()
            .foregroundStyle(Color.pink)
            Spacer()
        }
    }
}

#Preview {
    CourseInfoSectionViewComponent(collectionsViewModel: CollectionsViewModel(), course: .constant(CourseModel(creatorID: "", teacher: "", title: "Example title", description: "A not so long example of a description", imageURL: "No picture")), newValues: .constant(CreateCourseFormInputs()), changeInfoAlert: .constant(false), noChangesAlert: .constant(false))
}
