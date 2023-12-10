//
//  EditionSubView1.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 27/11/23.
//

import SwiftUI

/// The first step in the course editing process.
///
/// This view displays a header and a "Next" button to proceed to the next step in editing a course.
///
/// - Parameters:
///   - authViewModel: An observed object representing the authentication view model.
///   - collectionsViewModel: An observed object representing the collections view model.
struct EditionSubView1: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                HeaderViewComponent(headerModel: HeaderModel(headerType: .editCourse), frameSize: 100)
                NavigationLink {
                    EditionSubView2(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
                } label: {
                    ButtonViewComponent(title: "Next", foregroundColor: .gray.opacity(0.1), titleColor: .accentColor)
                }
                .padding()
            }
            .onAppear {
                collectionsViewModel.cleanCollectionsCache()
            }
        }
    }
}

#Preview {
    EditionSubView1(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel())
}
