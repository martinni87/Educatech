////
////  SearchView.swift
////  Educatech
////
////  Created by Martín Antonio Córdoba Getar on 15/10/23.
////
//
//import SwiftUI
//
//struct SearchView: View {
//    
//    @State var search: String = ""
//    @State var showResult: Bool = false
//    
//    @ObservedObject var authViewModel: AuthViewModel
//    @ObservedObject var coursesViewModel: CoursesViewModel
//    @ObservedObject var userViewModel: UserViewModel
//    
//    var body: some View {
//        VStack {
//            SearchBar(search: $search, showResult: $showResult)
//                .padding(.top, 20)
//            SearchResults(search: $search, showResult: $showResult)
//        }
//    }
//}
//
//struct SearchBar: View {
//    
//    @Binding var search: String
//    @Binding var showResult: Bool
//    
//    var body: some View {
//        VStack {
//            Rectangle()
//                .fill(.gray.opacity(0.25))
//                .frame(height: 50)
//                .clipShape(.capsule)
//                .overlay {
//                    HStack {
//                        TextField("New search... ", text: $search)
//                        Button {
//                            showResult.toggle()
//                        } label: {
//                            Image(systemName: "magnifyingglass")
//                        }
//                    }
//                    .padding(20)
//                }
//                .padding(.horizontal)
//            Rectangle()
//                .fill(.gray)
//                .frame(height: 0.5)
//                .ignoresSafeArea()
//        }
//    }
//}
//
//struct SearchResults: View {
//    
//    @Binding var search: String
//    @Binding var showResult: Bool
//    
//    var body: some View {
//        ScrollView {
//            if showResult {
//                Text("Se ha buscado: \(search)")
//            }
//        }
//        .padding(.top, 10)
//    }
//}
//
//struct SearchView_Previews: PreviewProvider {
//    
//    @State static var search: String = ""
//    @State static var showResult: Bool = false
//    @State static var authViewModel: AuthViewModel = AuthViewModel()
//    @State static var coursesViewModel: CoursesViewModel = CoursesViewModel()
//    @State static var userViewModel: UserViewModel = UserViewModel()
//    
//    static var previews: some View {
//        SearchView(authViewModel: authViewModel, coursesViewModel: coursesViewModel, userViewModel: userViewModel)
//        SearchBar(search: $search, showResult: $showResult)
//        SearchResults(search: $search, showResult: $showResult)
//    }
//}
