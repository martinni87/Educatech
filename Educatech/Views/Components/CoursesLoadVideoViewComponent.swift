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
                    .frame(maxWidth: 850)
                    .cornerRadius(10)
                    .overlay {
                        HStack {
                            Text(label)
                                .foregroundStyle(Color.gray)
                                .bold()
                            Spacer()
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
