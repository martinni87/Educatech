//
//  CreationSubView5.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 8/11/23.
//

import SwiftUI
import PhotosUI

struct CreationSubView5: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @Binding var formInputs: CreateCourseFormInputs
    @State var waitingResponse: Bool = false
    @State var closeForm: Bool = false
    @Environment (\.dismiss) var dismiss
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HeaderViewComponent(headerModel: HeaderModel(headerType: .createcourse5), frameSize: 70)
                    Spacer()
                    List{
                        Section("Course info"){
                            Text("Creator ID: ").bold() + Text("\(formInputs.creatorID)")
                            Text("Teacher: ").bold() + Text("\(formInputs.teacher)")
                            Text("Title: ").bold()  + Text("\(formInputs.title)")
                            HStack {
                                Text("Image: ").bold()
                                Text("\(formInputs.selectedPicture?.itemIdentifier ?? "Picture selected identifier")")
                                    .lineLimit(1)
                            }
                            Text("Category: ").bold()  + Text("\(formInputs.category)")
                            Text("Description: ").bold()  + Text("\(formInputs.description)")
                        }
                        Section("Videos") {
                            ForEach(Array(formInputs.selectedVideos.enumerated()), id:\.1) { i, video in
                                HStack {
                                    Text("Lesson \(i+1): ").bold()
                                    Text("\(video.itemIdentifier ?? "No video selected")")
                                        .lineLimit(1)
                                }
                            }
                        }
                    }
                    .foregroundStyle(.gray)
                    Spacer()
                    Button {
                        waitingResponse.toggle()
                    } label: {
                        ButtonViewComponent(title: "Create")
                    }
                    .padding(.top,20)
                    .padding(.bottom, 50)
                }
                .disabled(waitingResponse)
                if waitingResponse {
                    WaitingViewComponent()
                    .onAppear {
                        collectionsViewModel.createNewCourse(formInputs: formInputs, userData: authViewModel.userData!) //At this point userData is never null
                    }
                }
                
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
                    collectionsViewModel.cleanCollectionsCache()
                    waitingResponse.toggle()
                    closeForm = true
                }))
            })
            .alert(isPresented: $collectionsViewModel.creationWasSuccessful, content: {
                Alert(title: Text("Creation was successful ✅"), message: Text(collectionsViewModel.creationMsg), dismissButton: .cancel(Text("Finish"), action: {
                    collectionsViewModel.cleanCollectionsCache()
                    waitingResponse.toggle()
                    closeForm = true
                }))
            })
        }
    }
}

#Preview {
    CreationSubView5(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel(), formInputs: .constant(CreateCourseFormInputs(creatorID: "0000", teacher: "Teacher", title: "Title", description: "Description of the course itself", selectedPicture: nil, category: "Swift", selectedVideos: [])))
}
