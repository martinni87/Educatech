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
                    .onTapGesture {
                        if collectionsViewModel.allowContinue {
                            collectionsViewModel.allowContinue.toggle()
                        }
                    }
                CoursesTextFieldViewComponent(collectionsViewModel: collectionsViewModel, variable: $formInputs.imageURL, errorMsg: collectionsViewModel.imageURLErrorMsg, label: "Thumbnail picture", placeholder: "www.yourimage.com/pic.jpeg", tooltip: "Copy and paste the URL where your picture is stored")
                    .onTapGesture {
                        if collectionsViewModel.allowContinue {
                            collectionsViewModel.allowContinue.toggle()
                        }
                    }
                EmptyView()
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
                    ButtonViewComponent(title: "Reset form", foregroundColor: .gray.opacity(0.25), titleColor: (formInputs.title == "" && formInputs.imageURL == "" && formInputs.category == "") ? .gray : .pink.opacity(0.5))
                }
                .disabled(formInputs.title == "" && formInputs.imageURL == "" && formInputs.category == "")
            }
        }
        .padding()
    }
}

#Preview {
    CreationSubView2(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel())
}
