//
//  CourseDetailView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 22/9/23.
//

import SwiftUI

struct CourseDetailView: View {
    
    let course: CourseModel
    
    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: course.image)) { phase in
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
            Button {
                print("Starting course")
            } label: {
                Text("Start course")
                    .font(.system(size: 20))
                    .bold()
            }
            .buttonStyle(.borderedProminent)
            .tint(.accentColor)
            .padding(50)
        }
    }
}

struct CourseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CourseCardView(course: CourseModel(title: "Titulo de prueba", description: "Descripcion de prueba", image: "", creatorID: ""))
    }
}
