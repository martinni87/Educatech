//
//  SubscribedCoursesView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 22/9/23.
//

import SwiftUI

/// A view displaying the courses that the user has subscribed to.
///
/// This view includes a scrollable list of subscribed courses, each linking to a detailed view of the respective course.
///
/// - Parameters:
///   - authViewModel: An observed object representing the authentication view model.
///   - collectionsViewModel: An observed object representing the collections view model.
struct SubscribedView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    
    var body: some View {
            ScrollView {
                if let _ = authViewModel.userData?.subscriptions {
                    ForEach(collectionsViewModel.subscribedCourses, id:\.id) { course in
                        VStack {
                            NavigationLink {
                                CourseDetailView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel, course: course)
                            } label: {
                                ListRowViewComponent(authViewModel: authViewModel,
                                                     collectionsViewModel: collectionsViewModel,
                                                     course: course)
                            }
                        }
                    }
                }
            }
            .padding()
    }
}

#Preview {
    SubscribedView(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel())
}
