//
//  GalleryPhotoViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 16/11/23.
//

import SwiftUI
import PhotosUI

struct GalleryPhotoViewComponent: View {
    
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @Binding var selectedPicture: PhotosPickerItem?
    
    var body: some View {
        VStack {
            if selectedPicture == nil {
                PhotosPicker(selection: $selectedPicture, matching: .images, photoLibrary: .shared()) {
                    Label("Select", systemImage: "photo.badge.plus")
                }
            }
            else {
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
