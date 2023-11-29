//
//  SearchView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 15/10/23.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @Binding var isNewSearch: Bool
    @Binding var selection: String
    
    
    var body: some View {
        if isNewSearch {
            Text("Make a new search!")
                .bold()
                .foregroundStyle(Color.gray)
                .padding()
            Spacer()
        }
        if collectionsViewModel.searchHasEmptyResult {
            Text("Nothing to show...")
                .bold()
                .foregroundStyle(Color.gray)
                .padding()
            Spacer()
        }
        else {
            ScrollView {
                ForEach(collectionsViewModel.searchResults, id:\.id) { course in
                    if course.approved {
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
            .padding(.horizontal)
        }
    }
}

#Preview {
    SearchView(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel(), isNewSearch: .constant(false), selection: .constant(""))
}
