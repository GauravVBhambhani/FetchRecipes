//
//  DishCardView.swift
//  FetchRecipes
//
//  Created by Gaurav Bhambhani on 11/6/24.
//

import SwiftUI

struct DishCardView: View {
    let imageURL: URL?
    let name: String
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 16) {
            
            if let imageURL = imageURL {
                AsyncImage(url: imageURL) { image in
                    image.resizable()
                        .scaledToFill()
                         .frame(width: 200, height: 150)
                } placeholder: {
                    ProgressView()
                        .frame(width: 150, height: 100)
                }
                
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 200, height: 250)
                    .overlay(
                        Text("No Image")
                            .foregroundColor(.white)
                    )
            }
            
            cardText
                .foregroundStyle(.black)
                .padding(.top)
                .padding(.horizontal, 8)

        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(radius: 8)
    }
    
    var cardText: some View {
        VStack(alignment: .leading) {
            Text(name)
                .font(.headline)
//                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: 150, alignment: .leading)
                .lineLimit(2)
            
            HStack(spacing: 4) {
                Image(systemName: "clock.arrow.circlepath")
                Text("\(Int.random(in: 15..<45)) minutes")
            }
            .foregroundStyle(.gray)
        }
        .padding(.bottom, 16)
    }
}

#Preview {
    DishCardView(imageURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg"), name: "Tart Tatin")
}
