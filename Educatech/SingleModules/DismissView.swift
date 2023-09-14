//
//  DismissView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import SwiftUI

struct DismissView: View {
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        HStack {
            Spacer()
            Button("Cerrar"){
                dismiss()
            }
            .tint(.pink)
            .padding(10)
            .buttonStyle(.bordered)
        }
    }
}

struct DismissView_Previews: PreviewProvider {
    static var previews: some View {
        DismissView()
    }
}
