////
////  SearchBarViewComponent.swift
////  Educatech
////
////  Created by Martín Antonio Córdoba Getar on 12/11/23.
////
//
//import SwiftUI
//
//struct SearchBarViewComponent: View {
//    
//    @ObservedObject var authViewModel: AuthViewModel
//    @ObservedObject var collectionsViewModel: CollectionsViewModel
//    @Binding var searchIO: SearchIO
//    
//    var body: some View {
//        VStack {
//            VStack {
//                Rectangle()
//                    .fill(.gray.opacity(0.25))
//                    .frame(height: 50)
//                    .clipShape(.buttonBorder)
//                    .overlay {
//                        HStack {
//                            TextField("New search... ", text: $searchIO.search)
//                            Button {
//                                searchIO.isNewSearch = false
//                                collectionsViewModel.getCoursesByFileteredParameters(word: searchIO.search, category: searchIO.category)
//                            } label: {
//                                Image(systemName: "magnifyingglass")
//                            }
//                        }
//                        .padding(20)
//                    }
//                    .padding(.horizontal)
//                PickerViewComponent(variable: $searchIO.category, label: "Category")
//                    .padding(.horizontal)
//            }
//            
//            Rectangle()
//                .fill(.gray)
//                .frame(height: 0.5)
//                .ignoresSafeArea()
//        }
//    }
//}
//
//#Preview {
//    SearchBarViewComponent(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel(), searchIO: .constant(SearchIO()))
//}
