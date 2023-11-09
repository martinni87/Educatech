//
//  CreationSubView5.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 8/11/23.
//

import SwiftUI

struct CreationSubView5: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @Binding var formInputs: CreateCourseFormInputs
    @State var closeForm: Bool = false
    @Environment (\.dismiss) var dismiss
    
    
    var body: some View {
        NavigationStack {
            VStack {
                HeaderViewComponent(headerModel: HeaderModel(headerType: .createcourse5), frameSize: 70)
                Spacer()
                List{
                    Section("Course info"){
                        Text("Creator ID: ").bold() + Text("\(formInputs.creatorID)")
                        Text("Teacher: ").bold() + Text("\(formInputs.teacher)")
                        Text("Title: ").bold()  + Text("\(formInputs.title)")
                        HStack {
                            Text("Image URL: ").bold()
                            Text("\(formInputs.imageURL)")
                                .lineLimit(1)
                        }
                        Text("Category: ").bold()  + Text("\(formInputs.category)")
                        Text("Description: ").bold()  + Text("\(formInputs.description)")
                    }
                    Section("Videos") {
                        ForEach(Array(formInputs.videosURL.enumerated()), id:\.1) { i, url in
                            HStack {
                                Text("Lesson \(i): ").bold()
                                Text("\(url)")
                                    .lineLimit(1)
                            }
                        }
                    }
                }
                .foregroundStyle(.gray)
                Spacer()
                Button {
                    collectionsViewModel.createNewCourse(formInputs: formInputs, userData: authViewModel.userData!) //At this point userData is never null
                } label: {
                    ButtonViewComponent(title: "Create")
                }
                .padding(.top,20)
                .padding(.bottom, 50)
            }
            .onAppear {
                formInputs.creatorID = authViewModel.userData?.id ?? "0"
                formInputs.teacher = authViewModel.userData?.username ?? "Anonymous"
            }
            .fullScreenCover(isPresented: $closeForm) {
                MainView(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
            }
            .alert(isPresented: $collectionsViewModel.creationHasFailed, content: {
                Alert(title: Text("Creation has failed ❌"), message: Text(collectionsViewModel.creationMsg), primaryButton: .default(Text("Try again")), secondaryButton: .cancel(Text("Cancel"), action: {
                    collectionsViewModel.cleanCreationCache()
                    closeForm = true
                }))
            })
            .alert(isPresented: $collectionsViewModel.creationWasSuccessful, content: {
                Alert(title: Text("Creation was successful ✅"), message: Text(collectionsViewModel.creationMsg), dismissButton: .cancel(Text("Finish"), action: {
                    collectionsViewModel.cleanCreationCache()
                    closeForm = true
                }))
            })
        }
    }
}

#Preview {
    CreationSubView5(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel(), formInputs: .constant(CreateCourseFormInputs(creatorID: "53127489hn", teacher: "John Doe", title: "Example title", description: "Example description long text", imageURL: "https://www.youtube.com", category: "Swift", videosURL: ["Video1","Video2","Video3","Video4"])))
}
