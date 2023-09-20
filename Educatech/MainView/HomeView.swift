//
//  HomeView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 20/9/23.
//

import SwiftUI

struct HomeView: View {
    
    var email: String
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("Welcome \(email)")
            }
            .navigationTitle("News")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(email: "johndoe@mail.com")
    }
}
