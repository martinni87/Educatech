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
    @State var isNewSearch: Bool = true
    @State var selection: String = ""
    
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    PickerViewComponent(label: "Category to search:", variable: $selection)
                        .padding(.top, 5)
//                        .onChange(of: selection) { oldValue, newValue in
//                            collectionsViewModel.getCoursesByCategory(category: selection)
//                            isNewSearch = false
//                        }
                    Button {
                        collectionsViewModel.getCoursesByCategory(category: selection)
                        isNewSearch = false
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
                Rectangle()
                    .fill(.gray)
                    .frame(height: 0.5)
                    .ignoresSafeArea()
            }
            if isNewSearch {
                Text("Make a new search!")
                    .bold()
                    .foregroundStyle(Color.gray)
                    .padding()
            }
            if collectionsViewModel.searchHasEmptyResult {
                Text("Nothing to show...")
                    .bold()
                    .foregroundStyle(Color.gray)
                    .padding()
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
                .padding()
            }
            Spacer()
        }
    }
}

#Preview {
    SearchView(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel(), selection: "")
}
//            SearchBarViewComponent(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel, searchIO: $searchIO)
//                .padding(.top, 20)
//
//                ScrollView {
//                    ForEach(collectionsViewModel.searchResults, id:\.id) { course in
//                        NavigationLink {
//                            CourseDetailView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel, course: course)
//                        } label: {
//                            ListRowViewComponent(authViewModel: authViewModel,
//                                                           collectionsViewModel: collectionsViewModel,
//                                                           course: course)
//                        }
//                        .foregroundStyle(Color.black)
//                    }
//                }
//                .padding()
//            }
//        //            Spacer()
//    }
//}
//}

//#Preview {
//    SearchView(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel())
//}
