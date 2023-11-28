//
//  CourseInfoSectionViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 27/11/23.
//

import SwiftUI

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
