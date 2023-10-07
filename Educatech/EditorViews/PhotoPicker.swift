//
//  PhotoPicker.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 28/9/23.
//

import SwiftUI
import PhotosUI
import FileProviderUI

struct PictureSelector: View {
    
    @Binding var selectedItems: [PhotosPickerItem]
    
    var body: some View {
            PhotosPicker(selection: $selectedItems,
                         matching: .images) {
                Image(systemName: "tray.and.arrow.down.fill")
                    .symbolRenderingMode(.multicolor)
                    .foregroundColor(.accentColor)
            }
            .buttonStyle(.borderless)
    }
}

struct FileSelector: View {
    
    @Binding var selectedItems: [Image]
    
    var body: some View {
        Text("HOLA")
    }
}

struct PhotoPicker_Previews: PreviewProvider {
    
    @State static var selectedItems = [PhotosPickerItem(itemIdentifier: "1")]
    
    static var previews: some View {
        PictureSelector(selectedItems: $selectedItems)
    }
}
