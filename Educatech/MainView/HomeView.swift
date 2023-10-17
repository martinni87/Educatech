//
//  HomeView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 20/9/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var coursesViewModel: CoursesViewModel
    
    
    var body: some View {
        NavigationStack {
            Text("Home")
                .bold()
                .font(.headline)
            ScrollView {
                ForEach(coursesViewModel.allCourses, id:\.id) { course in
                    CourseCardView(course: course)
                }
            }
            .task {
                coursesViewModel.getAllCourses()
            }
//            .navigationTitle("Home")
//            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    
    @State static var authViewModel: AuthViewModel = AuthViewModel()
    @State static var coursesViewModel: CoursesViewModel = CoursesViewModel()
    
    static var previews: some View {
        HomeView(authViewModel: authViewModel, coursesViewModel: coursesViewModel)
    }
}
