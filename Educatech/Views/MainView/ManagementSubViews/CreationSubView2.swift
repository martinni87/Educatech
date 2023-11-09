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
    
    var body: some View {
        NavigationStack {
            HeaderViewComponent(headerModel: HeaderModel(headerType: .createcourse2), frameSize: 70)
            Spacer()
            VStack (alignment: .leading) {
                CoursesTextFieldViewComponent(collectionsViewModel: collectionsViewModel, variable: $formInputs.title, errorMsg: collectionsViewModel.titleErrorMsg, label: "Title", placeholder: "The title of your course", tooltip: "Write the title of your course")
                CoursesTextFieldViewComponent(collectionsViewModel: collectionsViewModel, variable: $formInputs.imageURL, errorMsg: collectionsViewModel.imageURLErrorMsg, label: "Thumbnail picture", placeholder: "www.yourimage.com/pic.jpeg", tooltip: "Copy and paste the URL where your picture is stored")
                EmptyView()
                PickerViewComponent(variable: $formInputs.category, label: "Category")
            }
            Spacer()
            Text("Good to go!")
                .foregroundStyle(collectionsViewModel.allowContinue ? Color.accentColor : Color.clear)
            Spacer()
            
            HStack {
                if collectionsViewModel.allowContinue {
                    NavigationLink {
                        CreationSubView3(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel, formInputs: $formInputs)
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
                    collectionsViewModel.cleanCreationCache()
                    formInputs = CreateCourseFormInputs()
                } label: {
                    ButtonViewComponent(title: "Reset form", foregroundColor: .gray.opacity(0.25), titleColor: (formInputs.title == "" && formInputs.imageURL == "" && formInputs.category == "HTML") ? .gray : .pink.opacity(0.5))
                }
                .disabled(formInputs.title == "" && formInputs.imageURL == "" && formInputs.category == "HTML")
            }
        }
        .padding()
    }
}

#Preview {
    CreationSubView2(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel())
}
