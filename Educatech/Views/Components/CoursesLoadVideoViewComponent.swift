//
//  CoursesLoadVideoViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 19/11/23.
//

import SwiftUI
import PhotosUI

/**
 A SwiftUI view component for loading videos in courses-related forms.
 
 - Note: This view includes a section for selecting videos and displays the label for the video loading section.
 - Parameters:
   - collectionsViewModel: An observed object managing collections-related operations.
   - selectedVideos: Binding to the array of selected video items.
   - label: The label for the video loading section.
   - colorScheme: Environment variable representing the color scheme.
 */
struct CoursesLoadVideoViewComponent: View {
    
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @Binding var selectedVideos: [PhotosPickerItem]
    let label: String
    @Environment (\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            HStack {
                // Section for selecting videos and displaying the label
                Rectangle()
                    .fill(colorScheme == .light ? .black.opacity(0.1) : .white.opacity(0.1))
                    .fill(collectionsViewModel.imageURLErrorMsg != nil ? .pink.opacity(0.1) : .clear)
                    .frame(height: 40)
                    .frame(maxWidth: 850)
                    .cornerRadius(10)
                    .overlay {
                        HStack {
                            // Display the label for the video loading section
                            Text(label)
                                .foregroundStyle(Color.gray)
                                .bold()
                            Spacer()
                            // Gallery video view component for selecting videos
                            GalleryVideoViewComponent(collectionsViewModel: collectionsViewModel, selectedVideos: $selectedVideos)
                        }
                        .padding()
                    }
            }
        }
    }
}

#Preview {
    CoursesLoadVideoViewComponent(collectionsViewModel: CollectionsViewModel(), selectedVideos: .constant([]), label: "Select videos")
}
