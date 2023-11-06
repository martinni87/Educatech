//
//  ManagementView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 22/9/23.
//

import SwiftUI

struct ManagementView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        Text("Management view")
    }
}

#Preview {
    ManagementView(authViewModel: AuthViewModel())
}
////    @ObservedObject var coursesViewModel: CoursesViewModel
////    
////    var body: some View {
////        NavigationStack {
////            Text("Editor")
////                .bold()
////                .font(.headline)
////            List {
////                NavigationLink {
////                    CreateCourseView(authViewModel: authViewModel, coursesViewModel: coursesViewModel)
////                } label: {
////                    Label("Create a new course", systemImage: "doc.badge.plus")
////                }
////                NavigationLink {
////                    ManagerCourseView(authViewModel: authViewModel, coursesViewModel: coursesViewModel)
////                } label: {
////                    Label("My managed courses", systemImage: "text.book.closed")
////                }
////            }
//////            .navigationTitle("Editor")
//////            .navigationBarTitleDisplayMode(.inline)
////            .task(priority: .high) {
////                coursesViewModel.getCoursesByCreatorID(creatorID: authViewModel.user?.id ?? "8z38yBr08GTnTEXzLtEYi5r9grH3")
////            }
////        }
////    }
////}
////
////struct EditorView_Previews: PreviewProvider {
////    
////    @State static var authViewModel: AuthViewModel = AuthViewModel()
////    @State static var coursesViewModel: CoursesViewModel = CoursesViewModel()
////    
////    static var previews: some View {
////        ManagementView(authViewModel: authViewModel, coursesViewModel: coursesViewModel)
////    }
////}
//
////
////  ManagementView.swift
////  Educatech
////
////  Created by Martín Antonio Córdoba Getar on 15/10/23.
////
//
//import SwiftUI
//
//struct ManagementView: View {
//    
//    @Environment (\.verticalSizeClass) var verticalSizeClass
//    @ObservedObject var authViewModel: AuthViewModel
//    @ObservedObject var coursesViewModel: CoursesViewModel
//    
//    var body: some View {
//        NavigationStack {
//            if verticalSizeClass == .regular {
//                VStack{
//                    Spacer()
//                    NavigationLink {
//                        CreationView(authViewModel: authViewModel, coursesViewModel: coursesViewModel)
//                    } label: {
//                        CreateOption()
//                    }
//                    Spacer()
//                    NavigationLink {
//                        EditionView(authViewModel: authViewModel, coursesViewModel: coursesViewModel)
//                    } label: {
//                        EditOption()
//                    }
//                    Spacer()
//                }
//            }
//            else {
//                HStack{
//                    Spacer()
//                    NavigationLink {
//                        CreationView(authViewModel: authViewModel, coursesViewModel: coursesViewModel)
//                    } label: {
//                        CreateOption()
//                    }
//                    Spacer()
//                    NavigationLink {
//                        EditionView(authViewModel: authViewModel, coursesViewModel: coursesViewModel)
//                    } label: {
//                        EditOption()
//                    }
//                    Spacer()
//                }
//            }
//        }
//    }
//}
//
//struct CreateOption: View {
//    
//    @Environment (\.colorScheme) var colorScheme
//        
//    var body: some View {
//        VStack {
//            Image("create_pic")
//                .resizable()
//                .scaledToFit()
//                .padding(.top, 10)
//            Text("CREATE")
//                .font(.system(.title, design: .rounded, weight: .black))
//                .padding(.bottom, 5)
//                .foregroundStyle(.indigo)
//        }
//        .frame(width: 200, height: 200)
//        .background(.gray.opacity(0.2))
//        .clipShape(.rect(cornerRadius: 10))
//        .shadow(color: .gray, radius: 10, x: 0.0, y: 0.0)
//    }
//}
//
//struct EditOption: View {
//    
//    @Environment (\.colorScheme) var colorScheme
//        
//    var body: some View {
//        VStack {
//            Image("edit_pic")
//                .resizable()
//                .scaledToFit()
//                .padding(.top, 10)
//            Text("EDIT")
//                .font(.system(.title, design: .rounded, weight: .black))
//                .padding(.bottom, 5)
//                .foregroundStyle(.brown)
//        }
//        .frame(width: 200, height: 200)
//        .background(.gray.opacity(0.2))
//        .clipShape(.rect(cornerRadius: 10))
//        .shadow(color: .gray, radius: 10, x: 0.0, y: 0.0)
//    }
//}
//
//struct EditorView_Previews: PreviewProvider {
//    
//    @State static var coursesViewModel: CoursesViewModel = CoursesViewModel()
//    @State static var authViewModel: AuthViewModel = AuthViewModel()
//    
//    static var previews: some View {
//        ManagementView(authViewModel: authViewModel, coursesViewModel: coursesViewModel)
//        CreateOption()
//        EditOption()
//    }
//}
