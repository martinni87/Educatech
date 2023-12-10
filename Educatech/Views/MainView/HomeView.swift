//
//  HomeView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 20/9/23.
//
//


import SwiftUI

/// A view displaying the home screen of the Educatech app.
///
/// This view includes a scrollable list of course carousels, featuring all courses and recommended courses based on user-selected categories.
///
/// - Parameters:
///   - authViewModel: An observed object representing the authentication view model.
///   - collectionsViewModel: An observed object representing the collections view model.
struct HomeView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    
    var body: some View {
        ScrollView {
            CardCarouselView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel, coursesPresented: collectionsViewModel.allCourses, sectionTitle: "All courses")
                .padding(.top, 20)
            ForEach(authViewModel.userData?.categories ?? [], id:\.self) { category in
                if !(collectionsViewModel.recommendedCourses[category]?.isEmpty ?? false) {
                    CardCarouselView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel, coursesPresented: collectionsViewModel.recommendedCourses[category] ?? [], sectionTitle: "Because you selected \(category)")
                        .task {
                            self.authViewModel.getCurrentUserData()
                            self.collectionsViewModel.getCoursesByCategories(categories: authViewModel.userData?.categories ?? [])
                        }
                }
            }
        }
    }
}

#Preview {
    HomeView(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel())
}
