//
//  SubscribedCoursesView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 22/9/23.
//

import SwiftUI

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
