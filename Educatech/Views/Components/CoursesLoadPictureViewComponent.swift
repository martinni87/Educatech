//
//  CoursesLoadPictureViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 18/11/23.
//

import SwiftUI
import PhotosUI

/**
 A SwiftUI view component for loading pictures in courses-related forms.
 
 - Note: This view includes a section for selecting a picture, displaying the selected picture's identifier, and handling errors.
 - Parameters:
   - collectionsViewModel: An observed object managing collections-related operations.
   - pictureItem: Binding to the selected picture item.
   - errorMsg: Binding to the error message related to image URLs.
   - label: The label for the picture loading section.
   - colorScheme: Environment variable representing the color scheme.
 */
struct CoursesLoadPictureViewComponent: View {
    
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @Binding var pictureItem: PhotosPickerItem?
    @Binding var errorMsg: String?
    let label: String
    @Environment (\.colorScheme) var colorScheme
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                // Section for selecting a picture and displaying its identifier
                Rectangle()
                    .fill(colorScheme == .light ? .black.opacity(0.1) : .white.opacity(0.1))
                    .fill(collectionsViewModel.imageURLErrorMsg != nil ? .pink.opacity(0.1) : .clear)
                    .frame(height: 40)
                    .frame(maxWidth: 850)
                    .cornerRadius(10)
                    .overlay {
                        HStack {
                            // Display the selected picture's identifier or a placeholder text
                            Text((pictureItem == nil ? "Select a picture" : pictureItem?.itemIdentifier) ?? "")
                                .foregroundStyle(Color.gray)
                                .bold()
                            Spacer()
                            // Gallery photo view component for selecting pictures
                            GalleryPhotoViewComponent(collectionsViewModel: collectionsViewModel, selectedPicture: $pictureItem)
                                .onChange(of: pictureItem) { _, _ in
                                    // Toggle allowContinue if needed and reset errorMsg
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
            // Display error message or "No error" if there is no error
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
