//
//  CardCarouselView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 10/11/23.
//

import SwiftUI

enum TypeOfContent {
    case all, recommended
}

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
