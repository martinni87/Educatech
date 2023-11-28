//
//  ManagementView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 22/9/23.
//

import SwiftUI
import PhotosUI

struct ManagementView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @Environment (\.verticalSizeClass) var verticalSizeClass
    @Environment (\.horizontalSizeClass) var horizontalSizeClass
    @State var videoSelected: [PhotosPickerItem] = []
    
    var body: some View {
        NavigationStack {
            
            if horizontalSizeClass == .compact {
                VStack{
                    Spacer()
                    NavigationLink {
                        CreationSubView1(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
                    } label: {
                        CreateOption()
                    }
                    Spacer()
                    NavigationLink {
                        EditionSubView1(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
                    } label: {
                        EditOption()
                    }
                    Spacer()
                }
            }
            else {
                VStack {
                    Spacer()
                    HStack{
                        Spacer()
                        NavigationLink {
                            CreationSubView1(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
                        } label: {
                            CreateOption()
                                .frame(minWidth: 200, minHeight: 200)
                                .frame(maxWidth: 400, maxHeight: 400)
                                .scaleEffect(horizontalSizeClass == .regular && verticalSizeClass == .regular ? 1.5 : 1)
                        }
                        Spacer()
                        NavigationLink {
                            EditionSubView1(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
                        } label: {
                            EditOption()
                                .frame(minWidth: 200, minHeight: 200)
                                .frame(maxWidth: 400, maxHeight: 400)
                                .scaleEffect(horizontalSizeClass == .regular && verticalSizeClass == .regular ? 1.5 : 1)
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct CreateOption: View {
    
    @Environment (\.colorScheme) var colorScheme
        
    var body: some View {
        VStack {
            Image("button_create_pic")
                .resizable()
                .scaledToFit()
                .padding(20)
            Text("CREATE")
                .font(.system(.title, design: .rounded, weight: .black))
                .padding(.bottom, 5)
                .foregroundStyle(.indigo)
        }
        .frame(width: 200, height: 200)
        .background(.gray.opacity(0.2))
        .clipShape(.rect(cornerRadius: 10))
    }
}

struct EditOption: View {
    
    @Environment (\.colorScheme) var colorScheme
        
    var body: some View {
        VStack {
            Image("button_edit_pic")
                .resizable()
                .scaledToFit()
                .padding(20)
            Text("EDIT")
                .font(.system(.title, design: .rounded, weight: .black))
                .padding(.bottom, 5)
                .foregroundStyle(.brown)
        }
        .frame(width: 200, height: 200)
        .background(.gray.opacity(0.2))
        .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    ManagementView(authViewModel: AuthViewModel(), collectionsViewModel: CollectionsViewModel())
}
