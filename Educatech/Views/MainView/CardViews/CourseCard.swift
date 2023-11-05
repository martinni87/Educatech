////
////  CourseCardView.swift
////  Educatech
////
////  Created by Martín Antonio Córdoba Getar on 22/9/23.
////
//
//import SwiftUI
//
//struct CourseCard: View {
//    
//    let course: CourseModel
//    @State var showDetailView: Bool?
//    @Environment (\.colorScheme) var colorScheme
//    
//    var body: some View {
//        NavigationLink {
//            CourseDetail(course: course)
//        } label: {
//            VStack (alignment: .leading, spacing: 20) {
//                AsyncImage(url: URL(string: course.imageURL)) { phase in
//                    if let image = phase.image {
//                        image
//                            .resizable()
//                            .scaledToFit()
//                    }
//                    else {
//                        WaitingAnimationView()
//                    }
//                }
//                VStack (alignment: .leading, spacing: 20){
//                    Text(course.title)
//                        .font(.system(size: 20))
//                        .fontWeight(.black)
//                    Text(course.description)
//                        .font(.caption)
//                }
//                .foregroundColor(colorScheme == .light ? .black : .white)
//                .multilineTextAlignment(.leading)
//                .lineLimit(2)
//                .padding(.horizontal, 20)
//            }
//            .shadow(color: .gray, radius: 5, x: 0, y: 3)
//        }
//        .padding(.bottom, 20)
//    }
//}
//
//struct CourseCard_Previews: PreviewProvider {
//    static var previews: some View {
//        CourseCard(course: COURSE_LIST_EXAMPLE[0])
//    }
//}
