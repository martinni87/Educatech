//
//  CreationSubView2.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 7/11/23.
//

import SwiftUI

struct CreationSubView2: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var coursesViewModel: CoursesViewModel
    @State var formInputs = CreateCourseFormInputs()
    
    var body: some View {
        NavigationStack {
            HeaderViewComponent(headerModel: HeaderModel(headerType: .createcourse2), frameSize: 70)
            Spacer()
            VStack (alignment: .leading) {
                CoursesTextFieldViewComponent(coursesViewModel: coursesViewModel, variable: $formInputs.title, errorMsg: coursesViewModel.titleErrorMsg, label: "Title", placeholder: "The title of your course", tooltip: "Write the title of your course")
                CoursesTextFieldViewComponent(coursesViewModel: coursesViewModel, variable: $formInputs.imageURL, errorMsg: coursesViewModel.imageURLErrorMsg, label: "Thumbnail picture", placeholder: "www.yourimage.com/pic.jpeg", tooltip: "Copy and paste the URL where your picture is stored")
                EmptyView()
                PickerViewComponent(variable: $formInputs.category, errorMsg: coursesViewModel.categoryErrorMsg, label: "Category")
            }
            Spacer()
            Text("Good to go!")
                .foregroundStyle(coursesViewModel.allowContinue ? Color.accentColor : Color.clear)
            Spacer()
            
            HStack {
                if coursesViewModel.allowContinue {
                    NavigationLink {
                        CreationSubView3()
                    } label: {
                        ButtonViewComponent(title: "Next", foregroundColor: .gray.opacity(0.25), titleColor: .accentColor)
                    }
                }
                else {
                    Button {
                        coursesViewModel.creationFormValidations(formInputs)
                    } label: {
                        ButtonViewComponent(title: "Check fields", foregroundColor: .gray.opacity(0.25), titleColor: .accentColor)
                    }
                }
                Button {
                    coursesViewModel.cleanCreationCache()
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
    CreationSubView2(authViewModel: AuthViewModel(), coursesViewModel: CoursesViewModel())
}
