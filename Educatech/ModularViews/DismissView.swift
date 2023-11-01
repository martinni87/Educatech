//
//  CancelButton.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import SwiftUI

struct CancelButton: View {
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            Button("Cancel"){
                dismiss()
            }
            .tint(.pink)
            .buttonStyle(.borderless)
        }
    }
}

struct CancelButton_Previews: PreviewProvider {
    static var previews: some View {
        CancelButton()
    }
}
