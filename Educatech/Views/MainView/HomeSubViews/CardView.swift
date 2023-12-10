//
//  CardViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 22/9/23.
//

import SwiftUI

/// A view displaying information about a course in card format.
///
/// This view is used to represent a course in a visually appealing card format, showing details such as the course title, teacher, category, and the number of students enrolled.
///
/// - Parameters:
///   - authViewModel: The view model managing authentication.
///   - collectionsViewModel: The view model managing collections.
///   - course: The course model containing information about the course to be displayed.
///   - verticalSizeClass: The vertical size class environment variable.
struct CardView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @State var course: CourseModel
    @Environment (\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                AsyncImageViewComponent(course: $course)
                    .frame(width: 300, height: 250)
                    .clipShape(.rect(cornerRadius: 10))
                HStack(alignment: .top) {
                    Text(course.title)
                        .lineLimit(1)
                        .foregroundStyle(Color.blackWhite)
                        .font(.title)
                        .bold()
                    Spacer()
                }
                HStack(alignment: .center) {
                    Label(course.teacher, systemImage: "graduationcap.fill")
                        .lineLimit(1)
                    Spacer()
                    Label(course.category, systemImage: "book.fill")
                        .lineLimit(1)
                        .padding(.trailing,40)
                }
                .foregroundStyle(Color.accentColor2)
                HStack {
                    Label("\(collectionsViewModel.allCourses.first(where: { $0.id == course.id })?.numberOfStudents ?? 0)", systemImage: "person.fill")
                        .lineLimit(1)
                        .foregroundStyle(Color.accentColor2)
                    Spacer()
                    Text("See more...")
                        .lineLimit(1)
                        .foregroundStyle(Color.accentColor)
                        .padding(.trailing,40)
                }
            }
        }
        .frame(width: 300, height: 350)
        .scaleEffect(verticalSizeClass == .compact ? 0.8 : 1)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    CardView(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel(), course: EXAMPLE_COURSE)
}
