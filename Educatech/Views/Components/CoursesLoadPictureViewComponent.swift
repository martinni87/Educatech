//
//  CoursesLoadPictureViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 18/11/23.
//

import SwiftUI
import PhotosUI

struct CoursesLoadPictureViewComponent: View {
    
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @Binding var pictureItem: PhotosPickerItem?
    @Binding var errorMsg: String?
    let label: String
    @Environment (\.colorScheme) var colorScheme
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Rectangle()
                    .fill(colorScheme == .light ? .black.opacity(0.1) : .white.opacity(0.1))
                    .fill(collectionsViewModel.imageURLErrorMsg != nil ? .pink.opacity(0.1) : .clear)
                    .frame(height: 40)
                    .frame(maxWidth: 1000)
                    .cornerRadius(10)
                    .overlay {
                        HStack {
                            Text((pictureItem == nil ? "Select a picture" : pictureItem?.itemIdentifier) ?? "")
                                .foregroundStyle(Color.gray)
                                .bold()
                            Spacer()
                            GalleryPhotoViewComponent(collectionsViewModel: collectionsViewModel, selectedPicture: $pictureItem)
                                .onChange(of: pictureItem) { _, _ in
                                    if collectionsViewModel.allowContinue {
                                        collectionsViewModel.allowContinue.toggle()
                                    }
                                    if errorMsg != nil {
                                        errorMsg = nil
                                    }
                                }
                        }
                        .padding()
                    }
            }
            Text(collectionsViewModel.imageURLErrorMsg ?? "No error")
                .font(.system(size: 14))
                .multilineTextAlignment(.leading)
                .foregroundStyle(collectionsViewModel.imageURLErrorMsg != nil ? .pink : .clear)
                .bold()
        }
    }
}

#Preview {
    CoursesLoadPictureViewComponent(collectionsViewModel: CollectionsViewModel(), pictureItem: .constant(PhotosPickerItem(itemIdentifier: "")), errorMsg: .constant("Error"), label: "Choose a picture")
}
