//
//  DishDetailView.swift
//  FetchRecipes
//
//  Created by Gaurav Bhambhani on 11/10/24.
//

import SwiftUI
import Kingfisher

struct DishDetailView: View {
    
    let dish: Recipe
    
    @Environment(\.dismiss) var dismiss
    
    @State private var isVideoExpanded = false
    @State private var isArticleExpanded = false
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            VStack {
                
                
                ZStack(alignment: .topLeading) {
                    
                    // Background Image
                    if let imageURL = dish.photoURLLarge {
                        KFImage(imageURL)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 300)
                            .clipped()
                            .edgesIgnoringSafeArea(.top)  // Extend to the top of the screen
                    }
                    
                    // Custom Back Button on Top Left
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "arrow.backward")
                            .font(.title2)
                            .padding()
                            .background(Color.black.opacity(0.6))
                            .clipShape(Circle())
                            .foregroundColor(.white)
                    }
                    .padding([.top, .leading], 16)
                }
                //                .frame(height: 300)  // Fixed height for the header
                
                Text(dish.name)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    if let youtubeURL = dish.youtubeURL {
                        Button(action: {
                            withAnimation {
                                isVideoExpanded.toggle()
                            }
                        }) {
                            Label ("Watch Recipe Video", systemImage: "video")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(8)
                                .padding(.horizontal)
                        }
                        
                        if isVideoExpanded {
                            VideoPlayerView(videoURL: youtubeURL)
                                .frame(height: 250)
                                .cornerRadius(12)
                                .padding(.horizontal)
                                .transition(.slide)
                        }
                    }
                    
                    
                    if let articleURL = dish.sourceURL {
                        NavigationLink(destination: ArticleWebView(articleURL: articleURL)) {
                            Label("Read Article", systemImage: "doc.text")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green.opacity(0.2))
                                .cornerRadius(8)
                                .padding(.horizontal)
                        }
                    }
                }
                .padding(.top)
            }
            .toolbar(.hidden)
        }
    }
}

//
//#Preview {
//    DishDetailView(dish: <#T##Recipe#>)
//}
