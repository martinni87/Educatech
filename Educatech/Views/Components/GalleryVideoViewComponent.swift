//
//  GalleryVideoViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 16/11/23.
//

import SwiftUI
import PhotosUI

struct GalleryVideoViewComponent: View {
    
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @Binding var selectedVideos: [PhotosPickerItem]
    
    var body: some View {
        VStack {
            if selectedVideos.isEmpty {
                PhotosPicker(selection: $selectedVideos, selectionBehavior: .default, matching: .videos, preferredItemEncoding: .compatible, photoLibrary: .shared()) {
                    Label("Select", systemImage: "video.badge.plus")
                }
            }
            else {
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
