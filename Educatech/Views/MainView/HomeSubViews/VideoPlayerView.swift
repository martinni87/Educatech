//
//  VideoPlayerView.swift
//  Educatech
//
//  Created by Martín Antonio Córdoba Getar on 9/11/23.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    
    @State var videoTitle: String = ""
    @State var videoURL: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                VideoPlayerViewComponent(videoURL: URL(string: videoURL)!)
            }
            .navigationBarTitle(videoTitle)
        }
    }
}

struct VideoPlayerViewComponent: UIViewControllerRepresentable {
    let videoURL: URL

    class Coordinator: NSObject {
        var player: AVPlayer?

        deinit {
            player?.pause()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let playerViewController = AVPlayerViewController()
        playerViewController.player = AVPlayer(url: videoURL)
        context.coordinator.player = playerViewController.player
        return playerViewController
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        // Update UI or handle state changes if needed
    }
}

#Preview {
    VideoPlayerView(videoURL: "https://www.youtube.com/watch?v=rwkPCt77Mcs")
}
