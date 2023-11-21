//
//  EditionSubView1.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 19/11/23.
//

import SwiftUI
import PhotosUI

struct EditionSubView1: View {
    
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
                                    EditionSubView2(authViewModel: authViewModel,
                                                    collectionsViewModel: collectionsViewModel,
                                                    currentValues: course)
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
    EditionSubView1(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel())
}
