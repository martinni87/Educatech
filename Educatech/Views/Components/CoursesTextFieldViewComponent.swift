//
//  CoursesTextFieldViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 29/10/23.
//

import SwiftUI

struct CoursesTextFieldViewComponent: View {
    
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @Binding var variable: String
    let errorMsg: String?
    let label: String
    let placeholder: String
    var tooltip: String
    @State var showTooltip = false
    @State var tooltipTimer: Timer?
    
    @Environment (\.colorScheme) var colorScheme
    
    var body: some View {
        VStack (alignment: .leading){
            Text(label)
                .foregroundColor(.gray)
                .bold()
            Rectangle()
                .fill(colorScheme == .light ? .black.opacity(0.1) : .white.opacity(0.1))
                .fill(errorMsg != nil ? .pink.opacity(0.1) : .clear)
                .frame(height: 40)
                .cornerRadius(10)
                .overlay {
                    HStack {
                        TextField(placeholder, text: $variable)
                            .padding()
                            .foregroundStyle(.gray)
                            .textFieldStyle(.plain)
                            .textInputAutocapitalization(.never)
                            .onTapGesture {
                                collectionsViewModel.cleanCollectionsCache()
                            }
                        Image(systemName: "questionmark.bubble")
                            .foregroundStyle(.gray)
                            .onTapGesture {
                                self.showTooltip.toggle()
                                // Hide tooltip after 2 seconds
                                tooltipTimer?.invalidate()
                                tooltipTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                                    showTooltip = false
                                }
                            }
                            .padding()
                    }
                }
            if showTooltip {
                Text(self.tooltip)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(showTooltip ? .gray : .clear)
                    .bold()
            }
            else {
                Text(errorMsg ?? "No error")
                    .font(.system(size: 14))
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(errorMsg != nil ? .pink : .clear)
                    .bold()
            }
        }
    }
}

#Preview {
    CoursesTextFieldViewComponent(collectionsViewModel: CollectionsViewModel(), variable: .constant(""), errorMsg: "nil", label: "Example", placeholder: "Example", tooltip: "Example")
}
