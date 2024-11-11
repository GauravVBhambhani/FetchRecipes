//
//  VideoPLayerView.swift
//  FetchRecipes
//
//  Created by Gaurav Bhambhani on 11/10/24.
//

import SwiftUI
import WebKit

struct VideoPlayerView: UIViewRepresentable {
    let videoURL: URL?
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.configuration.allowsInlineMediaPlayback = true
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        if let url = URL(string: videoURL!.absoluteString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

#Preview {
    VideoPlayerView(videoURL: URL(string: "https://www.youtube.com/watch?v=I3T3TNPiPcc"))
}
