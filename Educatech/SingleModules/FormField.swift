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
            VStack {
                Rectangle()
                    .fill(colorScheme == .light ? .black.opacity(0.2) : .white.opacity(0.2))
                    .frame(height: fieldType == .multiLine ? 150 : 50)
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
                                
                                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                .foregroundColor(editing ? (colorScheme == .light ? .black : .white) : .gray)
                                .padding()
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    variable = ""
                                    editing = true
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
                    .multilineTextAlignment(.center)
                    .foregroundStyle(showTooltip ? .gray : .clear)
            }
            
        }
    }
}

struct CreationFormField_Preview: PreviewProvider {
    
    @State static var variable = ""
    static var previews: some View {
        FormField(fieldType: .multiLine,
                  label: "Example",
                  placeholder: "jondoe@mail.com",
                  variable: $variable,
                  autocapitalization: false)
    }
}

