//
//  FormField.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 8/10/23.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct FormField: View {
    
    @State var fieldType: FormFieldTypes
    @State var title: String
    @Binding var variable: String
    @State var autocapitalization: Bool
    @State var editing = false
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(title)
                .foregroundColor(.gray)
                .bold()
            switch fieldType {
            case .singleLine:
                TextField(title, text: $variable)
                    .textInputAutocapitalization(!autocapitalization ? .never : .sentences)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom, 20)
            case .multiLine:
                TextEditor(text: $variable)
                    .padding(.horizontal,5)
                    .frame(height: 150)
                    .foregroundColor(!editing ? .gray : .black)
                    .border(.gray.opacity(0.3), width: 1)
                    .padding(.bottom, 20)
                    .onTapGesture {
                        variable = ""
                        editing = true
                    }
            case .secure:
                SecureField(title, text: $variable)
                    .textInputAutocapitalization(!autocapitalization ? .never : .sentences)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom, 20)
            }
        }
    }
}

struct CreationFormField_Preview: PreviewProvider {
    
    @State static var variable = ""
    static var previews: some View {
        FormField(fieldType: .singleLine,
                          title: "Example",
                          variable: $variable,
                          autocapitalization: true)
    }
}

