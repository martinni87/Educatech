//
//  EditionSubView1.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 27/11/23.
//

import SwiftUI

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
