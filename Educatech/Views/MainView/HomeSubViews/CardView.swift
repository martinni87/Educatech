//
//  CardViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 22/9/23.
//

import SwiftUI

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
                    Label("\(course.numberOfStudents)", systemImage: "person.fill")
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
