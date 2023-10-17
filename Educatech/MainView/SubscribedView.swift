//
//  SubscribedCoursesView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 22/9/23.
//

import SwiftUI

struct SubscribedView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var coursesViewModel: CoursesViewModel
    @ObservedObject var userViewModel: UserViewModel
    
    var body: some View {
        NavigationStack {
            Text("My Lessons")
                .bold()
                .font(.headline)
            ScrollView {
                ForEach(coursesViewModel.subscribedCourses, id:\.id) { course in
                    CourseCardView(course: course)
                }
            }
            .task {
                coursesViewModel.getSubscribedCoursesByIDList(coursesID: userViewModel.subscriptionList)
                print(userViewModel.subscriptionList)
            }
//            .navigationTitle("My Lessons")
//            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SubscribedCoursesView_Previews: PreviewProvider {
    
    @State static var authViewModel: AuthViewModel = AuthViewModel()
    @State static var coursesViewModel: CoursesViewModel = CoursesViewModel()
    @State static var userViewModel: UserViewModel = UserViewModel()
    
    static var previews: some View {
        SubscribedView(authViewModel: authViewModel, coursesViewModel: coursesViewModel, userViewModel: userViewModel)
    }
}
