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
    @Binding var coursesViewModel: CoursesViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(coursesViewModel.managedCourses, id:\.id) { course in
                    ManagedCourseCardView(course: course)
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
        ManagerCourseView(authViewModel: $authViewModel, coursesViewModel: $coursesViewModel)
    }
}
