//
//  HomeView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 20/9/23.
//
//


import SwiftUI

struct HomeView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        Text("HOME")
    }
}

#Preview {
    HomeView(authViewModel: AuthViewModel())
}
  
////    @ObservedObject var coursesViewModel: CoursesViewModel
////    @ObservedObject var userViewModel: UserViewModel
////    
////    var body: some View {
////        NavigationStack {
////            Text("Home")
////                .bold()
////                .font(.headline)
////            ScrollView {
////                ForEach(coursesViewModel.allCourses, id:\.id) { course in
////                    CourseCardView(course: course)
////                }
////            }
////            .task {
////                coursesViewModel.getAllCourses()
////            }
////        }
////    }
////}
////
////struct HomeView_Previews: PreviewProvider {
////    
////    @State static var authViewModel: AuthViewModel = AuthViewModel()
////    @State static var coursesViewModel: CoursesViewModel = CoursesViewModel()
////    @State static var userViewModel: UserViewModel = UserViewModel()
////    
////    static var previews: some View {
////        HomeView(authViewModel: authViewModel, coursesViewModel: coursesViewModel, userViewModel: userViewModel)
////    }
////}
//
//import SwiftUI
//
//struct HomeView: View {
//    
//    @ObservedObject var authViewModel: AuthViewModel
//    @ObservedObject var coursesViewModel: CoursesViewModel
//    @ObservedObject var userViewModel: UserViewModel
//    
//    var body: some View {
//        ScrollView {
//            VStack (alignment: .leading) {
//                Text("New in Educatech!")
//                    .font(.title)
//                    .bold()
//                HorizontalScrollList(coursesViewModel: coursesViewModel, contentType: .newCourses)
//            }
//            .padding()
//            VStack (alignment: .leading) {
//                Text("Recommended for you")
//                    .font(.title)
//                    .bold()
//                HorizontalScrollList(coursesViewModel: coursesViewModel, contentType: .newCourses)
//            }
//            .padding()
//            VStack (alignment: .leading) {
//                Text("Best valued")
//                    .font(.title)
//                    .bold()
//                HorizontalScrollList(coursesViewModel: coursesViewModel, contentType: .newCourses)
//            }
//            .padding()
//        }
//    }
//}
//
//struct HorizontalScrollList: View {
//    
//    @ObservedObject var coursesViewModel: CoursesViewModel
//    let contentType: ContentType?
//    
//    var body: some View {
//        ScrollView (.horizontal, showsIndicators: false) {
//            switch contentType {
//            case .newCourses:
//                HStack (spacing: 40) {
//                    ForEach (coursesViewModel.allCourses, id:\.id) { course in
//                        CardView(course: course)
//                    }
//                }
//            case .recommendedCourses:
//                Text("Recommended")
//            case .bestValuedCourses:
//                Text("Best valued")
//            default:
//                Text("Other type of content")
//            }
//        }
//        .task {
//            coursesViewModel.getAllCourses()
//        }
//    }
//}
//
//struct CardView: View {
//    
//    let course: CourseModel
//    
//    var body: some View {
//        VStack (alignment: .leading) {
//            AsyncImage(url: URL(string: course.imageURL)) { phase in
//                if let image = phase.image {
//                    image
//                        .resizable()
//                        .scaledToFit()
//                }
//                else {
//                    WaitingAnimationView()
//                }
//            }
//                .clipShape(.rect(cornerRadius: 10))
//            
//            Text(course.title)
//                .font(.title2)
//                .bold()
//            HStack (alignment: .top) {
//                VStack (alignment: .leading) {
//                    Text(course.teacher)
//                    HStack (spacing: 5) {
//                        Text("\(course.rateStars.toStringRoundedToDecimal(2))")
//                        Text(paintRating(course.rateStars))
//                        Text("(\(course.numberOfValorations))")
//                    }
//                }
//                Spacer()
//                VStack(alignment: .trailing) {
//                    Text(course.category)
//                    Text("\(course.numberOfStudents) students")
//                }
//            }
//            .foregroundStyle(Color.gray)
//            HStack {
////                Text("\(course.price.toStringRoundedToDecimal(2)) €")
////                    .font(.title3)
////                    .bold()
//                Spacer()
//                Button("See more...") {
//                    print("Subscribe to \(course.title)")
//                }
//            }
//        }
//        .frame(width: 300, height: 300)
//    }
//    
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
//}
//
//
//
//struct HomeView_Previews: PreviewProvider {
//    
//    @State static var authViewModel: AuthViewModel = AuthViewModel()
//    @State static var coursesViewModel: CoursesViewModel = CoursesViewModel()
//    @State static var userViewModel: UserViewModel = UserViewModel()
//    
//    static var previews: some View {
//        HomeView(authViewModel: authViewModel, coursesViewModel: coursesViewModel, userViewModel: userViewModel)
//    }
//}
