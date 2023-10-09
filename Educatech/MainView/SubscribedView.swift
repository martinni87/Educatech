//
//  SubscribedCoursesView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 22/9/23.
//

import SwiftUI

struct SubscribedView: View {
    var body: some View {
        Text("Here goes all the stuff I'm learning")
    }
}

struct SubscribedCoursesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SubscribedView()
                .navigationTitle("My Lessons")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
