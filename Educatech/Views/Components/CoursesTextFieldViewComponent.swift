//
//  CoursesTextFieldViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 29/10/23.
//

import SwiftUI

/**
 A SwiftUI view component representing a text field used in courses-related forms.

 - Note: This view includes a text field for user input, with an optional error message and tooltip.
 - Parameters:
   - collectionsViewModel: An observed object managing collections-related operations.
   - variable: Binding to the text field's input variable.
   - errorMsg: An optional error message to display.
   - label: The label for the text field.
   - placeholder: The placeholder text for the text field.
   - tooltip: The tooltip message to display when the question mark icon is tapped.
 */
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
            // Label for the text field
            Text(label)
                .foregroundColor(.gray)
                .bold()
            
            // Text field with placeholder and optional error styling
            Rectangle()
                .fill(colorScheme == .light ? .black.opacity(0.1) : .white.opacity(0.1))
                .fill(errorMsg != nil ? .pink.opacity(0.1) : .clear)
                .frame(height: 40)
                .frame(maxWidth: 850)
                .cornerRadius(10)
                .overlay {
                    HStack {
                        // TextField for user input
                        TextField(placeholder, text: $variable)
                            .padding()
                            .foregroundStyle(Color.accentColor)
                            .textFieldStyle(.plain)
                            .textInputAutocapitalization(.never)
                            .onTapGesture {
                                collectionsViewModel.cleanCollectionsCache()
                            }
                        // Question mark icon to show tooltip
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
            // Display tooltip or error message
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
