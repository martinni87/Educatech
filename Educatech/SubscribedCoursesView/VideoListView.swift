//
//  VideoListView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 14/10/23.
//

import SwiftUI

struct VideoListView: View {
    
    @ObservedObject var coursesViewModel: CoursesViewModel
    var body: some View {
        Text("List of videos in the course")
            .font(.largeTitle)
            .bold()
    }
}
//
//#Preview {
//    VideoListView()
//}

