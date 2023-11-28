//
//  AsyncImageViewComponent.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 25/11/23.
//

import SwiftUI

struct AsyncImageViewComponent: View {
    
    @Binding var course: CourseModel
    @State var isLoading: Bool = true
    @State var showNotAvailable: Bool = false
    
    var body: some View {
        if showNotAvailable {
            Rectangle()
                .fill(Gradient(colors: [.accentColor, .background]))
                .frame(minWidth: 90, maxWidth: 300, minHeight: 90, maxHeight: 250)
                .cornerRadius(15)
                .overlay {
                    VStack {
                        Text("Maximun downloads reached")
                            .fontWeight(.black)
                        Text("Thanks for using Educatech")
                    }
                    .multilineTextAlignment(.center)
                    .font(.caption)
                    .foregroundStyle(Color.white)
                }
        }
        else {
            AsyncImage(url: URL(string: course.imageURL)) { phase in
                switch phase {
                case .empty, .failure:
                    WaitingAnimationViewComponent()
                        .onAppear {
                            Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
                                if isLoading {
                                    showNotAvailable = true
                                }
                            }
                        }
                case .success(let image):
                    image
                        .resizable()
                        .onAppear {
                            isLoading = false
                        }
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    AsyncImageViewComponent(course: .constant(.init(creatorID: "000", teacher: "Teacher", title: "Title", description: "Description of example course", imageURL: "")))
}
