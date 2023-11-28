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
//        .background(Image("Background").resizable().scaledToFill().ignoresSafeArea())
    }
}

#Preview {
    HomeView(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel())
}
