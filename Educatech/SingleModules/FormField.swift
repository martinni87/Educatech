//
//  FormField.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 8/10/23.
//

import SwiftUI

struct FormField: View {
    
    @Environment (\.colorScheme) var colorScheme
    
    @State var fieldType: FormFieldTypes
    @State var label: String
    @State var placeholder: String
    @State var tooltip: String?
    @Binding var variable: String
    @State var autocapitalization: Bool
    
    @State var editing = false
    @State var showTooltip = false
    @State var tooltipTimer: Timer?
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(label)
                .foregroundColor(.gray)
                .bold()
            VStack (alignment: .trailing) {
                Rectangle()
                    .fill(colorScheme == .light ? .black.opacity(0.1) : .white.opacity(0.1))
                    .frame(height: fieldType == .multiLine ? 200 : 50)
                    .cornerRadius(10)
                    .overlay {
                        switch fieldType {
                        case .singleLine:
                            HStack {
                                TextField(placeholder, text: $variable)
                                    .textInputAutocapitalization(!autocapitalization ? .never : .sentences)
                                    .textFieldStyle(.plain)
                                    .padding()
                                Image(systemName: "questionmark.bubble")
                                    .onTapGesture(perform: {
                                        showTooltip.toggle()
                                        
                                        // Hide tooltip after 2 seconds
                                        tooltipTimer?.invalidate()
                                        tooltipTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { _ in
                                            showTooltip = false
                                        })
                                    })
                                    .foregroundColor(.gray)
                                    .padding()
                            }

                        case .multiLine:
                            TextEditor(text: $variable)
                                .cornerRadius(8)
                                .underline(color: .red)
                                .foregroundColor(editing ? (colorScheme == .light ? .black : .white) : .gray)
                                .padding()
                                .onTapGesture {
                                    if !editing {
                                        variable = ""
                                        editing = true
                                    }
                                }
                        case .secure:
                            HStack {
                                SecureField(placeholder, text: $variable)
                                    .textInputAutocapitalization(!autocapitalization ? .never : .sentences)
                                    .textFieldStyle(.plain)
                                    .padding()
                                Image(systemName: "questionmark.bubble")
                                    .onTapGesture(perform: {
                                        showTooltip.toggle()
                                        
                                        // Hide tooltip after 2 seconds
                                        tooltipTimer?.invalidate()
                                        tooltipTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { _ in
                                            showTooltip = false
                                        })
                                    })
                                    .foregroundColor(.gray)
                                    .padding()
                            }
                        }
                    }
                Text(tooltip ?? "Needed \(label)")
                    .multilineTextAlignment(.trailing)
                    .foregroundStyle(showTooltip ? .gray : .clear)
            }
            
        }
    }
}

struct CreationFormField_Preview: PreviewProvider {
    
    @State static var variable = "fdsafasdfasdfadsfasd"
    static var previews: some View {
        VStack {
            FormField(fieldType: .singleLine,
                      label: "Example",
                      placeholder: "jondoe@mail.com",
                      variable: $variable,
                      autocapitalization: false)
            FormField(fieldType: .singleLine,
                      label: "Example",
                      placeholder: "jondoe@mail.com",
                      variable: $variable,
                      autocapitalization: false)
            FormField(fieldType: .multiLine,
                      label: "Example",
                      placeholder: "jondoe@mail.com",
                      variable: $variable,
                      autocapitalization: false)
            Button("Whatever"){
                print("whatever")
            }
        }
    }
}

