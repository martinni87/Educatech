//
//  CourseDetailView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 22/9/23.
//

import SwiftUI

struct CourseDetail: View {
    
    let course: CourseModel
    @State var showVideos: Bool = false
    
    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: course.imageURL)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                }
                else {
                    WaitingAnimationView()
                }
            }
            VStack (alignment: .leading, spacing: 20){
                Text(course.title)
                    .font(.system(size: 30))
                    .fontWeight(.black)
                Text(course.description)
                    .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, 10)
            
            if !showVideos {
                Button {
                    showVideos.toggle()
                } label: {
                    Text("Start course")
                        .font(.system(size: 20))
                        .bold()
                }
                .buttonStyle(.borderedProminent)
                .tint(.accentColor)
                .padding(50)
            }
            else {
                Text("Lista de videos")
                    .font(.title)
                    .bold()
                    .padding(.top,30)
                VStack {
                    NavigationLink("Video 1") {
                        Text("Video 1")
                    }
                    NavigationLink("Video 1") {
                        Text("Video 1")
                    }
                    NavigationLink("Video 1") {
                        Text("Video 1")
                    }
                }
            }
        }
    }
}

struct CourseDetail_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetail(course: COURSE_LIST_EXAMPLE[0])
    }
}
