//
//  RegisterSubView3.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 4/11/23.
//

import SwiftUI

struct RegisterSubView3: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @Binding var formInputs: RegistrationFormInputs
    @Environment (\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        //MARK: Selectable categories
        NavigationStack {
            VStack {
                Spacer()
                HeaderViewComponent(headerModel: HeaderModel(headerType: .register3), frameSize: 70)
                Spacer()
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), alignment: .center)], alignment: .center, spacing: 16) {
                    ForEach(CATEGORIES, id: \.self) { category in
                        CategoryButtonViewComponent(selection: category, formInputs: $formInputs)
                    }
                }
                Spacer()
                NavigationLink {
                    RegisterSubView4(authViewModel: authViewModel, formInputs: $formInputs)
                } label: {
                    ButtonViewComponent(title: "Next", foregroundColor: .gray.opacity(0.25), titleColor: .accentColor)
                }
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    RegisterSubView3(authViewModel: AuthViewModel(), formInputs: .constant(RegistrationFormInputs()))
}
