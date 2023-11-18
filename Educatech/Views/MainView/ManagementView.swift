//
//  ManagementView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 22/9/23.
//

import SwiftUI

struct ManagementView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @Environment (\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        NavigationStack {
            if verticalSizeClass == .regular {
                VStack{
                    Spacer()
                    NavigationLink {
                        CreationSubView1(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
                    } label: {
                        CreateOption()
                    }
                    Spacer()
                    NavigationLink {
                        Text("Edition view")
                    } label: {
                        EditOption()
                    }
                    Spacer()
                }
            }
            else {
                HStack{
                    Spacer()
                    NavigationLink {
                        CreationSubView1(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
                    } label: {
                        CreateOption()
                    }
                    Spacer()
                    NavigationLink {
                        Text("Edition view")
                    } label: {
                        EditOption()
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
