//
//  ListRowViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 11/11/23.
//

import SwiftUI

struct ListRowViewComponent: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @State var course: CourseModel
    @Environment (\.colorScheme) var colorScheme

    var body: some View {
        
        Rectangle()
            .fill(colorScheme == .light ? Color.gray.opacity(0.2) : Color.gray.opacity(0.2))
            .frame(height: 110)
            .frame(maxWidth: 850)
            .clipShape(.rect(cornerRadius: 15))
            .overlay {
                HStack {
                    AsyncImageViewComponent(course: $course)
                        .clipShape(.rect(cornerRadius: 10))
                        .frame(width: 128, height: 90)
                        .padding(10)
                    VStack (alignment: .leading, spacing: 5){
                        HStack (alignment: .top) {
                            Text(course.title)
                                .font(.title2)
                                .fontWeight(.black)
                                .lineLimit(1)
                            VStack (alignment: .leading) {
                                Label(course.teacher, systemImage: "graduationcap")
                                Label(course.category, systemImage: "book")
                            }
                            .font(.caption)
                            .bold()
                            .foregroundStyle(Color.gray)
                        }
                        Text(course.description)
                            .font(.subheadline)
                            .lineLimit(3)
                            .multilineTextAlignment(.leading)
                    }
                    .padding(10)
                Spacer()
                }
                .foregroundStyle(colorScheme == .light ? Color.black : Color.white)
            }
            
    }
}

#Preview {
    ListRowViewComponent(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel(), course: CourseModel(id: "1234",creatorID: "5678",teacher: "Anonymous",title: "Example",description: "Example course for preview only. Extra text to test multiline, it should be ok if it does not pass above 2 lines",imageURL: "",category: "Swift",videosURL: ["Video1", "Video2", "Video3"]))
}
