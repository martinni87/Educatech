//
//  CardCarouselView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 10/11/23.
//

import SwiftUI

/// The type of content displayed in the carousel, all content available in database or recommended based on subscribed categories
enum TypeOfContent {
    case all, recommended
}

/// A view displaying a horizontal carousel of course cards.
///
/// This view presents a horizontal scrolling carousel of course cards, allowing users to explore and navigate through a collection of courses.
///
/// - Parameters:
///   - authViewModel: The view model managing authentication.
///   - collectionsViewModel: The view model managing collections.
///   - coursesPresented: An array of course models to be presented in the carousel.
///   - sectionTitle: The title of the section represented by the carousel.
struct CardCarouselView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    var coursesPresented: [CourseModel]
    let sectionTitle: String
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(sectionTitle)
                .font(.largeTitle)
                .bold()
                .padding(.horizontal, 20)
            ScrollView(.horizontal) {
                HStack { 
                    ForEach(coursesPresented, id: \.id) { course in
                        if course.approved {
                            NavigationLink {
                                CourseDetailView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel, course: course)
                            } label: {
                                CardView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel, course: course)
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding(.bottom,50)
    }
}

#Preview {
    CardCarouselView(authViewModel: AuthViewModel(),
                     collectionsViewModel: CollectionsViewModel(),
                     coursesPresented: [EXAMPLE_COURSE],
                     sectionTitle: "Section title")
}
