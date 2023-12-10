//
//  GalleryPhotoViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 16/11/23.
//

import SwiftUI
import PhotosUI

/**
 A SwiftUI view component for selecting and displaying photos from the photo library.
 
 - Note: This view includes a `PhotosPicker` for selecting photos and additional controls for changing or clearing the selected photo.
 - Parameters:
   - collectionsViewModel: An observed object managing collections-related operations.
   - selectedPicture: Binding to the selected photo item.
 */
struct GalleryPhotoViewComponent: View {
    
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @Binding var selectedPicture: PhotosPickerItem?
    
    var body: some View {
        VStack {
            // Displaying PhotosPicker for selecting photos
            if selectedPicture == nil {
                PhotosPicker(selection: $selectedPicture, matching: .images, photoLibrary: .shared()) {
                    Label("Select", systemImage: "photo.badge.plus")
                }
            }
            else {
                // Displaying controls for changing or clearing the selected photo
                HStack {
                    PhotosPicker(selection: $selectedPicture, matching: .images, photoLibrary: .shared()) {
                        Label("Change", systemImage: "rectangle.2.swap")
                    }
                    Button {
                        selectedPicture = nil
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

#Preview {
    GalleryPhotoViewComponent(collectionsViewModel: CollectionsViewModel(), selectedPicture: .constant(nil))
}
