//
//  MainView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/9/23.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        
        NavigationView {
            TabView {
                Text("Welcome \(authViewModel.user?.email ?? "dummy@mail.com")")
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                Text("Second tab view")
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    SignoutButton(authViewModel: authViewModel)
                }
            }
            .navigationTitle("Educatech")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(authViewModel: AuthViewModel())
    }
}
