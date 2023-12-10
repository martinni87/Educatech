//
//  EditionSubView2.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 19/11/23.
//

import SwiftUI
import PhotosUI

/// The second step in the course editing process.
///
/// This view displays a list of courses available for editing. If there are no courses, a message and an empty view are shown.
///
/// - Parameters:
///   - authViewModel: An observed object representing the authentication view model.
///   - collectionsViewModel: An observed object representing the collections view model.
struct EditionSubView2: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    
    var body: some View {
        NavigationStack {
            if !(collectionsViewModel.managedCourses.isEmpty) {
                ScrollView {
                    ForEach(collectionsViewModel.managedCourses, id:\.id) { course in
                        VStack {
                            NavigationLink {
                                if let _ = authViewModel.userData {
                                    EditionSubView3(authViewModel: authViewModel,
                                                    collectionsViewModel: collectionsViewModel,
                                                    course: course)
                                }
                            } label: {
                                ListRowViewComponent(authViewModel: authViewModel,
                                                     collectionsViewModel: collectionsViewModel,
                                                     course: course)
                            }
                        }
                    }
                }
            }
            else {
                VStack {
                    Text("No courses created ... ")
                        .font(.title2)
                        .bold()
                        .padding()
                    Image("app_empty_view")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipShape(.circle)
                }
            }
        }
        .padding()
    }
}

#Preview {
    EditionSubView2(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel())
}
