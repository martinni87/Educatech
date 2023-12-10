//
//  CreationSubView3.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 9/11/23.
//

import SwiftUI

/// A subview for creating a new course - step 3.
///
/// This view is part of the course creation process. It includes a header, a text editor for course description, and navigation links.
///
/// - Parameters:
///   - authViewModel: An observed object representing the authentication view model.
///   - collectionsViewModel: An observed object representing the collections view model.
///   - formInputs: A binding to the form inputs for creating a course.
struct CreationSubView3: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @Binding var formInputs: CreateCourseFormInputs
    @State var hasError: Bool = false
    @Environment (\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HeaderViewComponent(headerModel: HeaderModel(headerType: .createcourse3), frameSize: 70)
                    .padding(.top, verticalSizeClass == .compact ? 15 : 0)
                TextEditor(text: $formInputs.description)
                    .frame(height: verticalSizeClass == .compact ? 200 : 300)
                    .frame(maxWidth: 850)
                    .border(Color.gray, width: 1)
                    .padding()
                if collectionsViewModel.allowContinue {
                    Text("Good to go!")
                        .foregroundStyle(Color.accentColor)
                }
                else if hasError {
                    Text("Description must not be empty")
                        .foregroundStyle(Color.pink)
                }
                else {
                    Text("Clear text to reserve space")
                        .foregroundStyle(Color.clear)
                }
                Spacer()
                if collectionsViewModel.allowContinue {
                    NavigationLink {
                        CreationSubView4(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel, formInputs: $formInputs)
                            .onAppear {
                                collectionsViewModel.allowContinue.toggle()
                            }
                    } label: {
                        ButtonViewComponent(title: "Next", foregroundColor: .gray.opacity(0.1), titleColor: .accentColor)
                    }
                }
                else {
                    Button {
                        if formInputs.description == "" {
                            hasError = true
                            collectionsViewModel.allowContinue = false
                        }
                        else {
                            hasError = false
                            collectionsViewModel.allowContinue = true
                        }
                    } label: {
                        ButtonViewComponent(title: "Check fields", foregroundColor: .gray.opacity(0.1), titleColor: .accentColor)
                    }
                }
            }
        }
    }
}

#Preview {
    CreationSubView3(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel(), formInputs: .constant(CreateCourseFormInputs()))
}
