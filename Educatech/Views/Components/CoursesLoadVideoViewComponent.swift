//
//  CoursesLoadVideoViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 19/11/23.
//

import SwiftUI
import PhotosUI

struct CoursesLoadVideoViewComponent: View {
    
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @Binding var selectedVideos: [PhotosPickerItem]
    let label: String
    @Environment (\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            HStack {
                Rectangle()
                    .fill(colorScheme == .light ? .black.opacity(0.1) : .white.opacity(0.1))
                    .fill(collectionsViewModel.imageURLErrorMsg != nil ? .pink.opacity(0.1) : .clear)
                    .frame(height: 40)
                    .frame(maxWidth: 1000)
                    .cornerRadius(10)
                    .overlay {
                        HStack {
                            Text(label)
                                .foregroundStyle(Color.gray)
                                .bold()
                            Spacer()
                            GalleryVideoViewComponent(collectionsViewModel: collectionsViewModel, selectedVideos: $selectedVideos)
//                                .onChange(of: selectedVideos) { _, _ in
//                                    if collectionsViewModel.allowContinue {
//                                        collectionsViewModel.allowContinue.toggle()
//                                    }
//                                    if errorMsg != nil {
//                                        errorMsg = nil
//                                    }
//                                }
                        }
                        .padding()
                    }
                
                
                
                //
                //                TextField("Video URL", text: $videoURL)
                //                    .onTapGesture {
                //                        self.errorMsg = nil
                //                        self.videoURL = ""
                //                    }
                //                    .textFieldStyle(.roundedBorder)
                //                    .textInputAutocapitalization(.never)
                //                Spacer()
                //                Image(systemName: "video.badge.plus")
                //                    .foregroundStyle(Color.accentColor)
                //                    .onTapGesture {
                //                        videoURL.validateURLString { isValid, errorMsg in
                //                            if !isValid {
                //                                self.errorMsg = errorMsg
                //                            }
                //                            else {
                //                                formInputs.videosURL.append(videoURL)
                //                                self.videoURL = ""
                //                            }
                //                        }
                //                        print("Added video URL: \(videoURL)")
                //                        print("Updated videosURL: \(formInputs.videosURL)")
                //                    }
                //                    .padding()
                //            }
                //            Text(errorMsg ?? "No error")
                //                .font(.system(size: 14))
                //                .multilineTextAlignment(.leading)
                //                .foregroundStyle(errorMsg != nil ? .pink : .clear)
                //                .bold()
                //        }
            }
        }
    }
}

#Preview {
    CoursesLoadVideoViewComponent(collectionsViewModel: CollectionsViewModel(), selectedVideos: .constant([]), label: "Select videos")
}

//#Preview {
//    CoursesLoadVideoViewComponent(collectionsViewModel: CollectionsViewModel(), selectedVideos: .constant([]), errorMsg: .constant("Error"), label: "Select videos")
//}
