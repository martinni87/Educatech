//
//  SearchView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 15/10/23.
//

import SwiftUI

/// A view for searching and displaying courses based on user-defined criteria.
///
/// This view allows users to perform searches and displays the results in a scrollable list of courses. It provides feedback messages for different search scenarios.
///
/// - Parameters:
///   - authViewModel: An observed object representing the authentication view model.
///   - collectionsViewModel: An observed object representing the collections view model.
///   - isNewSearch: A binding variable indicating whether a new search is being performed.
///   - selection: A binding variable representing the selected category for filtering the search results.
struct SearchView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @Binding var isNewSearch: Bool
    @Binding var selection: String
    
    
    var body: some View {
        // Display message for a new search
        if isNewSearch {
            Text("Make a new search!")
                .bold()
                .foregroundStyle(Color.gray)
                .padding()
            Spacer()
        }
        // Display message for empty search results
        if collectionsViewModel.searchHasEmptyResult {
            Text("Nothing to show...")
                .bold()
                .foregroundStyle(Color.gray)
                .padding()
            Spacer()
        }
        else {
            // Display scrollable list of search results
            ScrollView {
                ForEach(collectionsViewModel.searchResults, id:\.id) { course in
                    if course.approved {
                        // Navigate to the detailed view of the course when tapped
                        NavigationLink {
                            CourseDetailView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel, course: course)
                        } label: {
                            // Display a row representing the searched course
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
