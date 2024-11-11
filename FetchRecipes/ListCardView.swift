//
//  ListCardView.swift
//  FetchRecipes
//
//  Created by Gaurav Bhambhani on 11/10/24.
//

import SwiftUI

struct ListCardView: View {
    
    let imageURL: URL?
    let name: String
    
    var body: some View {
        
        HStack (alignment: .top) {
            
            cardText
                .padding(.top)
                .padding(.horizontal, 8)
            
            if let imageURL = imageURL {
                AsyncImage(url: imageURL) { image in
                    image.resizable()
                        .scaledToFill()
                         .frame(width: 150, height: 100)
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
            
            

        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
//        .shadow(radius: 8)
        .padding(.top)
        .frame(maxWidth: .infinity)
    }
    
    var cardText: some View {
        VStack(alignment: .leading) {
            Text(name)
                .font(.headline)
//                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: 150, alignment: .leading)
                .lineLimit(2)
            
            Spacer()
            
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
    ListCardView(imageURL: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg"), name: "Tart Tatin")
}
