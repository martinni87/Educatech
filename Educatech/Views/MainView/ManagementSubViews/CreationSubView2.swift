//
//  CreationSubView2.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 7/11/23.
//

import SwiftUI

struct CreationSubView2: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @State var formInputs = CreateCourseFormInputs()
    @Environment (\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            Spacer()
            HeaderViewComponent(headerModel: HeaderModel(headerType: .createcourse2), frameSize: 70)
            Spacer()
            VStack (alignment: .center) {
                CoursesTextFieldViewComponent(collectionsViewModel: collectionsViewModel, variable: $formInputs.title, errorMsg: collectionsViewModel.titleErrorMsg, label: "Title", placeholder: "The title of your course", tooltip: "Write the title of your course")
                    .onTapGesture {
                        if collectionsViewModel.allowContinue {
                            collectionsViewModel.allowContinue.toggle()
                        }
                    }
                
                CoursesLoadPictureViewComponent(collectionsViewModel: collectionsViewModel, pictureItem: $formInputs.selectedPicture, errorMsg: $collectionsViewModel.imageURLErrorMsg, label: "Choose a picture")
                
                
                PickerViewComponent(label: "Category", variable: $formInputs.category)
                    .onTapGesture {
                        collectionsViewModel.categoryErrorMsg = nil
                        if collectionsViewModel.allowContinue {
                            collectionsViewModel.allowContinue.toggle()
                        }
                    }
                Text(collectionsViewModel.categoryErrorMsg ?? "No error")
                    .font(.system(size: 14))
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(collectionsViewModel.categoryErrorMsg != nil ? .pink : .clear)
                    .bold()
            }
            Spacer()
            Text("Good to go!")
                .foregroundStyle(collectionsViewModel.allowContinue ? Color.accentColor : Color.clear)
            Spacer()
            HStack {
                if collectionsViewModel.allowContinue {
                    NavigationLink {
                        CreationSubView3(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel, formInputs: $formInputs)
                            .onAppear {
                                collectionsViewModel.allowContinue.toggle()
                            }
                    } label: {
                        ButtonViewComponent(title: "Next", foregroundColor: .gray.opacity(0.25), titleColor: .accentColor)
                    }
                }
                else {
                    Button {
                        collectionsViewModel.creationFormValidations(formInputs)
                    } label: {
                        ButtonViewComponent(title: "Check fields", foregroundColor: .gray.opacity(0.25), titleColor: .accentColor)
                    }
                }
                Button {
                    collectionsViewModel.cleanCollectionsCache()
                    formInputs = CreateCourseFormInputs()
                } label: {
                    ButtonViewComponent(title: "Reset form", foregroundColor: .gray.opacity(0.25), titleColor: (formInputs.title == "" && formInputs.selectedPicture == nil && formInputs.category == "") ? .gray : .pink.opacity(0.5))
                }
                .disabled(formInputs.title == "" && formInputs.selectedPicture == nil && formInputs.category == "")
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    CreationSubView2(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel())
}
