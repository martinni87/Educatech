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
    let course: CourseModel
    @Environment (\.colorScheme) var colorScheme

    var body: some View {
        
        Rectangle()
            .fill(Color.gray.opacity(0.2))
            .frame(height: 110)
            .frame(maxWidth: 1000)
            .clipShape(.rect(cornerRadius: 15))
            .overlay {
                HStack {
                    AsyncImage(url: URL(string: course.imageURL)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 90)
                                .clipShape(.rect(cornerRadius: 10))
                        }
                        else {
                            WaitingAnimationViewComponent()
                        }
                    }
                    .padding(.leading, 10)
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
    ListRowViewComponent(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel(), course: CourseModel(id: "1234",creatorID: "5678",teacher: "Anonymous",title: "Example",description: "Example course for preview only. Extra text to test multiline, it should be ok if it does not pass above 2 lines",imageURL: "https://images.unsplash.com/photo-1590479773265-7464e5d48118?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",category: "Swift",videosURL: ["Video1", "Video2", "Video3"]))
}
