//
//  CreationSubView3.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 9/11/23.
//

import SwiftUI

struct CreationSubView3: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @Binding var formInputs: CreateCourseFormInputs
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HeaderViewComponent(headerModel: HeaderModel(headerType: .createcourse3), frameSize: 70)
                TextEditor(text: $formInputs.description)
                    .frame(height: 400)
                    .border(Color.gray, width: 1)
                    .padding()
                NavigationLink {
                    CreationSubView4(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel, formInputs: $formInputs)
                } label: {
                    ButtonViewComponent(title: "Next", foregroundColor: .gray.opacity(0.3), titleColor: .accentColor)
                }
            }
        }
    }
}

#Preview {
    CreationSubView3(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel(), formInputs: .constant(CreateCourseFormInputs()))
}
