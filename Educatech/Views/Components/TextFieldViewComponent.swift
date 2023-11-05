//
//  TextFieldViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 29/10/23.
//

import SwiftUI

struct TextFieldViewComponent: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    let type: CustomFieldType
    
    @Binding var variable: String
    @State var secureIsActive: Bool
    
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
//                .fill(colorScheme == .light ? .black.opacity(0.1) : .white.opacity(0.1))
//                .fill(errorMsg != nil ? .pink.opacity(0.1) : .clear)
                .frame(height: 40)
                .cornerRadius(10)
                .overlay {
                    HStack {
                        Group {
                            if secureIsActive {
                                SecureField(placeholder, text: $variable)
                            }
                            else {
                                TextField(placeholder, text: $variable)
                            }
                        }
                        .padding()
                        .foregroundStyle(.gray)
                        .textFieldStyle(.plain)
                        .textInputAutocapitalization(.never)
                        .onTapGesture {
                            authViewModel.cleanCache()
                        }
                        HStack {
                            if type == .secure {
                                Image(systemName: secureIsActive ? "eye" : "eye.slash")
                                    .foregroundStyle(.gray)
                                    .onTapGesture {
                                        self.secureIsActive.toggle()
                                    }
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
                        }
                        .padding()
                    }
                }
            if showTooltip {
                Text(self.tooltip)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(showTooltip ? .gray : .clear)
                    .bold()
            }
            else {
                Text(errorMsg ?? "No error")
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(errorMsg != nil ? .pink : .clear)
                    .bold()
            }
        }
    }
}

#Preview {
    TextFieldViewComponent(authViewModel: AuthViewModel(), type: .simple, variable: .constant(""), secureIsActive: false, errorMsg: nil, label: "Example", placeholder: "This is an example", tooltip: "Tooltip string")
}
