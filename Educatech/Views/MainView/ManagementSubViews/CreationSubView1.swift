//
//  CreationSubView1.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 22/9/23.
//

import SwiftUI

/// A subview for creating a new course - step 1.
///
/// This view is part of the course creation process. It includes a header and a navigation link to the next step.
///
/// - Parameters:
///   - authViewModel: An observed object representing the authentication view model.
///   - collectionsViewModel: An observed object representing the collections view model.
struct CreationSubView1: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                HeaderViewComponent(headerModel: HeaderModel(headerType: .createcourse1), frameSize: 100)
                NavigationLink {
                    CreationSubView2(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
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
    CreationSubView1(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel())
}
