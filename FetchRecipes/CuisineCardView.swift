//
//  CuisineCardView.swift
//  FetchRecipes
//
//  Created by Gaurav Bhambhani on 11/10/24.
//

import SwiftUI

struct CuisineCardView: View {
    let cuisine: String
    let imageURL: URL?
    
    var body: some View {
        VStack (alignment: .leading) {
            VStack {
                
                if let imageURL = imageURL {
                    AsyncImage(url: imageURL) { image in
                        image.resizable()
                            .scaledToFill()
                            .frame(height: 100)
                        //                        .cornerRadius(10)
                    } placeholder: {
                        ProgressView()
                            .frame(height: 100)
                    }
                } else {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 100)
                        .overlay(
                            Text("No Image")
                                .foregroundColor(.white)
                            
                        )
                }
                
                
                
            }
            .frame(width: 150, height: 150)
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .shadow(radius: 4)
            
            Text(cuisine)
                .foregroundStyle(.black)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.top, 5)
            
            Text("recipes")
                .foregroundStyle(.gray)
                .font(.headline)
                .multilineTextAlignment(.center)
                
        }
        .padding(.bottom)
    }
}

#Preview {
    CuisineCardView(cuisine: "American", imageURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"))
}
