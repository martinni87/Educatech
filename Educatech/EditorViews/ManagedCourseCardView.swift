//
//  ManagedCourseCardView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 22/9/23.
//

import SwiftUI

struct ManagedCourseCardView: View {
    
    @State var course: CourseModel
    @State var showDetailView: Bool?
    @Environment (\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationLink {
            ManagedCourseDetailView(course: $course)
        } label: {
            VStack (alignment: .leading){
                Text(course.title)
                    .font(.system(size: 20))
                    .fontWeight(.black)
                Text(course.description)
                    .font(.caption)
            }
            .foregroundColor(colorScheme == .light ? .black : .white)
            .multilineTextAlignment(.leading)
            .lineLimit(1)
            .padding(.horizontal, 20)
            
        }
    }
}

struct ManagedCourseCardView_Previews: PreviewProvider {
    static var previews: some View {
        ManagedCourseCardView(course: CourseModel(title: "Titulo de prueba", description: "Descripcion de prueba", image: "", creatorID: "8z38yBr08GTnTEXzLtEYi5r9grH3"))
    }
}
