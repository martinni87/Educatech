//
//  ManagerCourseView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 7/10/23.
//

import SwiftUI

struct ManagerCourseView: View {
    
    //Binding View Models
    @Binding var authViewModel: AuthViewModel
    @ObservedObject var coursesViewModel: CoursesViewModel
    
    var body: some View {
        NavigationStack {
            if coursesViewModel.managedCourses == [] {
                VStack {
                    Spacer()
                    Text("You don't have currently any course created")
                        .font(.title2)
                        .bold()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                    Spacer()
                }
            }
            List {
                ForEach(coursesViewModel.managedCourses, id:\.id) { course in
                    ManagedCourseCardView(course: course, coursesViewModel: coursesViewModel)
                }
            }
            .navigationTitle("My managed courses")
        }
    }
}

struct ManagerCourseView_Previews: PreviewProvider {
    
    @State static var authViewModel: AuthViewModel = AuthViewModel()
    @State static var coursesViewModel: CoursesViewModel = CoursesViewModel()
    
    static var previews: some View {
        ManagerCourseView(authViewModel: $authViewModel, coursesViewModel: coursesViewModel)
    }
}
