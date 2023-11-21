//
//  CreationSubView1.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 22/9/23.
//

import SwiftUI

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
                    ButtonViewComponent(title: "Next", foregroundColor: .gray.opacity(0.3), titleColor: .accentColor)
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
    
//    var body: some View {
//        VStack {
//            HeaderViewComponent(headerModel: HeaderModel(headerType: .createCourse), frameSize: 100)
//            if verticalSizeClass == .compact {
//                HStack (alignment: .firstTextBaseline, spacing: 20){
//                    CreationForm(formParameters: $formInputs)
//                }
//            }
//            else {
//                VStack {
//                    Image("video-editing")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(height: 100)
//                    CreationForm(formParameters: $formInputs)
//                }
//            }
//            Button {
//                if let email = authViewModel.user?.email {
//                    coursesViewModel.createNewCourse(title: formParameters.title,
//                                                     description: formParameters.description,
//                                                     imageURL: formParameters.imageURL,
//                                                     creatorID: authViewModel.user?.id ?? "",
//                                                     teacher: String(email.prefix(upTo: email.firstIndex(of: "@")!)),
//                                                     category: formParameters.category/*,*/
//                                                     /*price: Double(formParameters.price) ?? 0.00*/)
//                }
//                if let error = coursesViewModel.error {
//                    errorParameters.thereIsError = true
//                    errorParameters.message = error
//                }
//                errorParameters.showMsg = true
//                
//            } label: {
//                Text("Create")
//            }
//            .buttonStyle(.bordered)
//            .tint(.green)
//        }
//        .onAppear {
//            formParameters.description = LOREMIPSUM
//        }
//        .padding(30)
//        .alert(isPresented: $errorParameters.showMsg) {
//            Alert(title: Text(errorParameters.thereIsError ? "Something went wrong" : "Congratulations!"),
//                  message: Text(errorParameters.message),
//                  dismissButton: .default(Text("OK")) {
//                // Dismiss the current view and go back to the previous one
//                if !errorParameters.thereIsError {
//                    formParameters.title = ""
//                    formParameters.description = ""
//                    formParameters.imageURL = ""
//                    presentationMode.wrappedValue.dismiss()
//                }
//                errorParameters.showMsg = false
//                errorParameters.thereIsError = false
//                errorParameters.message = "New course created successfully! 😎"
//            })
//        }
//        .navigationTitle("New course creation")
//    }
//}

//struct CreationView_Previews: PreviewProvider {
//    
//    @State static var coursesViewModel = CoursesViewModel()
//    @State static var authViewModel = AuthViewModel()
//    static var previews: some View {
//        CreationView(authViewModel: authViewModel, coursesViewModel: coursesViewModel)
//    }
//}
