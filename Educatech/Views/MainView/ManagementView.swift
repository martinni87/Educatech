//
//  ManagementView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 22/9/23.
//

import SwiftUI
import PhotosUI

/// A view for managing course content, providing options for creating and editing courses.
///
/// This view allows users to create and edit courses, providing navigation links to corresponding subviews for each operation.
///
/// - Parameters:
///   - authViewModel: An observed object representing the authentication view model.
///   - collectionsViewModel: An observed object representing the collections view model.
///   - verticalSizeClass: Environment variable representing the vertical size class (compact or regular).
///   - horizontalSizeClass: Environment variable representing the horizontal size class (compact or regular).
///   - videoSelected: State variable storing the selected videos for course creation or editing.
struct ManagementView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    @ObservedObject var collectionsViewModel: CollectionsViewModel
    @Environment (\.verticalSizeClass) var verticalSizeClass
    @Environment (\.horizontalSizeClass) var horizontalSizeClass
    @State var videoSelected: [PhotosPickerItem] = []
    
    var body: some View {
        NavigationStack {
            // Display different layouts based on horizontal size class
            if horizontalSizeClass == .compact {
                VStack{
                    Spacer()
                    // Navigation link for creating a new course
                    NavigationLink {
                        CreationSubView1(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
                    } label: {
                        CreateOption()
                    }
                    Spacer()
                    // Navigation link for editing existing courses
                    NavigationLink {
                        EditionSubView1(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
                    } label: {
                        EditOption()
                    }
                    Spacer()
                }
            }
            else {
                // Regular layout for larger screens (e.g., iPad)
                VStack {
                    Spacer()
                    HStack{
                        Spacer()
                        // Navigation link for creating a new course
                        NavigationLink {
                            CreationSubView1(authViewModel: authViewModel, collectionsViewModel: collectionsViewModel)
                        } label: {
                            CreateOption()
                                .frame(minWidth: 200, minHeight: 200)
                                .frame(maxWidth: 400, maxHeight: 400)
                                .scaleEffect(horizontalSizeClass == .regular && verticalSizeClass == .regular ? 1.5 : 1)
                        }
                        Spacer()
                        // Navigation link for editing existing courses
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

/// A view component for the "Create" option.
struct CreateOption: View {
    
    @Environment (\.colorScheme) var colorScheme
        
    var body: some View {
        VStack {
            // Image for the "Create" option
            Image("button_create_pic")
                .resizable()
                .scaledToFit()
                .padding(20)
            // Text label for the "Create" option
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

/// A view component for the "Edit" option.
struct EditOption: View {
    
    @Environment (\.colorScheme) var colorScheme
        
    var body: some View {
        VStack {
            // Image for the "Edit" option
            Image("button_edit_pic")
                .resizable()
                .scaledToFit()
                .padding(20)
            // Text label for the "Edit" option
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
