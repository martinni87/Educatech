//
//  CreationSubView4.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 7/11/23.
//

import SwiftUI

struct CreationSubView4: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var coursesViewModel: CoursesViewModel
    @Binding var formInputs: CreateCourseFormInputs
    
    var body: some View {
        NavigationStack {
            HeaderViewComponent(headerModel: HeaderModel(headerType: .createcourse4), frameSize: 70)
            AddVideoViewComponent(formInputs: $formInputs)
                .padding()
            List {
                Section ("Loaded videos") {
                    ForEach(formInputs.videosURL, id:\.self) { url in
                        Text(url)
                    }
                }
            }
            Spacer()
            NavigationLink {
                CreationSubView5(authViewModel: authViewModel, coursesViewModel: coursesViewModel, formInputs: $formInputs)
            } label: {
                ButtonViewComponent(title: "Next", foregroundColor: .gray.opacity(0.3), titleColor: .accentColor)
            }
        }
    }
}

struct AddVideoViewComponent: View {
    
    @Binding var formInputs: CreateCourseFormInputs
    @State var videoURL = ""
    @State var errorMsg: String?
    @Environment (\.colorScheme) var colorScheme
    
    var body: some View {
        VStack (alignment: .leading){
            HStack {
                TextField("Video URL", text: $videoURL)
                    .onTapGesture {
                        self.errorMsg = nil
                        self.videoURL = ""
                    }
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                Spacer()
                Image(systemName: "video.badge.plus")
                    .foregroundStyle(Color.accentColor)
                    .onTapGesture {
                        videoURL.validateURLString { isValid, errorMsg in
                            if !isValid {
                                self.errorMsg = errorMsg
                            }
                            else {
                                formInputs.videosURL.append(videoURL)
                                self.videoURL = ""
                            }
                        }
                        print("Added video URL: \(videoURL)")
                        print("Updated videosURL: \(formInputs.videosURL)")
                    }
                    .padding()
            }
            Text(errorMsg ?? "No error")
                .font(.system(size: 14))
                .multilineTextAlignment(.leading)
                .foregroundStyle(errorMsg != nil ? .pink : .clear)
                .bold()
        }
    }
}

#Preview {
    CreationSubView4(authViewModel: AuthViewModel(), coursesViewModel: CoursesViewModel(), formInputs: .constant(CreateCourseFormInputs()))
}
