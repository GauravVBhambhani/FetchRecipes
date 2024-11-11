//
//  EmptyStateView.swift
//  FetchRecipes
//
//  Created by Gaurav Bhambhani on 11/11/24.
//

import SwiftUI

struct EmptyStateView: View {
    
    let message: String
    
    var body: some View {
        
        VStack {
            Image("fetch")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .foregroundColor(.gray)
                .padding(.bottom, 16)
            
            Text(message)
                .font(.title2)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
}

#Preview {
    EmptyStateView(message: "We're continuously fetching new tasty recipes. Stay tuned!")
}
