//
//  GalleryVideoViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 16/11/23.
//

import SwiftUI
import PhotosUI

/**
 A SwiftUI view component for selecting and displaying videos from the photo library.
 
 - Note: This view includes a `PhotosPicker` for selecting videos and additional controls for changing or clearing the selected videos.
 - Parameters:
   - collectionsViewModel: An observed object managing collections-related operations.
   - selectedVideos: Binding to the array of selected video items.
 */
struct GalleryVideoViewComponent: View {
    
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @Binding var selectedVideos: [PhotosPickerItem]
    
    var body: some View {
        VStack {
            // Displaying PhotosPicker for selecting videos
            if selectedVideos.isEmpty {
                PhotosPicker(selection: $selectedVideos, selectionBehavior: .default, matching: .videos, preferredItemEncoding: .compatible, photoLibrary: .shared()) {
                    Label("Select", systemImage: "video.badge.plus")
                }
            }
            else {
                // Displaying controls for changing or clearing the selected videos
                HStack {
                    PhotosPicker(selection: $selectedVideos, selectionBehavior: .continuousAndOrdered, matching: .videos, preferredItemEncoding: .compatible, photoLibrary: .shared()) {
                        Label("Change", systemImage: "rectangle.2.swap")
                    }
                    Button {
                        selectedVideos = []
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
        
    }
}

#Preview {
    GalleryVideoViewComponent(collectionsViewModel: CollectionsViewModel(), selectedVideos: .constant([]))
}
