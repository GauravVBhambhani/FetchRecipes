//
//  ArticleWebView.swift
//  FetchRecipes
//
//  Created by Gaurav Bhambhani on 11/10/24.
//

import SwiftUI
import WebKit

struct ArticleWebView: UIViewRepresentable {
    let articleURL: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: articleURL))
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {}
}
