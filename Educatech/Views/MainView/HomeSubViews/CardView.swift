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
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                AsyncImage(url: URL(string: course.imageURL)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 250)
                            .clipShape(.rect(cornerRadius: 10))
                    }
                    else {
                        WaitingAnimationViewComponent()
                    }
                }
                HStack(alignment: .top) {
                    Text(course.title)
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                HStack(alignment: .center) {
                    Label(course.teacher, systemImage: "graduationcap")
                    Spacer()
                    Label(course.category, systemImage: "book")
                }
                HStack {
                    Label("\(course.numberOfStudents)", systemImage: "person")
                    Spacer()
                    Text("See more...")
                    .foregroundStyle(Color.accentColor)
                }
//                HStack(alignment: .top) {
//                    Text("\(course.rateStars.toStringRoundedToDecimal(2))")
//                    Text(paintRating(course.rateStars))
//                    Text("(\(course.numberOfValorations))")
//                    Spacer()
//                    Text("\(course.numberOfStudents) students")
//                }
            }
            .foregroundStyle(.gray)
            .frame(width: 300, height: 300)
        }
    }
    
//    func paintRating(_ number: Double) -> String {
//        var result = ""
//        let iterations = Int(number)
//        
//        if number == 0 {
//            return "☆☆☆☆☆"
//        }
//        else if iterations > 0 && iterations < 5 {
//            for _ in 1 ... iterations {
//                result += "★"
//            }
//            for _ in 1 ... 5 - iterations {
//                result += "☆"
//            }
//            return result
//        }
//        else {
//            return "★★★★★"
//        }
//    }
}

#Preview {
    CardView(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel(), course: CourseModel(creatorID: "0", teacher: "Teacher", title: "Title", description: "Description", imageURL: "https://images.unsplash.com/photo-1590479773265-7464e5d48118?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",category: "Swift", videosURL: ["Video1", "Video2", "Video3"]))
}
