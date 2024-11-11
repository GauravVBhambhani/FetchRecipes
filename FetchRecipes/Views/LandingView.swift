//
//  ContentView.swift
//  FetchRecipes
//
//  Created by Gaurav Bhambhani on 11/6/24.
//

import SwiftUI

struct LandingView: View {
    
    @StateObject private var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Fetch Recipes")
                    .font(.largeTitle)
                    .bold()
                    .padding(.leading)
                Spacer()
                
                if networkManager.recipes.isEmpty {
                    EmptyStateView(message: "We're continuously fetching new tasty recipes. Stay tuned!")
                    Spacer()
                }
                else {
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            
                            Text("Popular Dishes")
                                .font(.title2)
                                .bold()
                                .padding(.horizontal)
                            
                            if networkManager.recipes.isEmpty {
                                ProgressView()
                                    .frame(height: 200)
                                    .padding(.horizontal)
                            } else {
                                let popularDishes = Array(networkManager.recipes.shuffled().prefix(5))
                                
                                // Horizontal Scroll
                                ScrollView(.horizontal, showsIndicators: false) {
                                    
                                    HStack(spacing: 16) {
                                        ForEach(popularDishes) { dish in
                                            NavigationLink(destination: DishDetailView(dish: dish)) {
                                                DishCardView(imageURL: dish.photoURLSmall, name: dish.name)
                                                    .padding()
                                            }
                                            
                                            // Rectangle()
                                            // .frame(width: 150, height: 150)
                                        }
                                    }
                                    .padding(.horizontal)
                                    
                                }
                                // .frame(maxHeight: .infinity)
                            }
                            
                            
                            Text("Explore Cuisines")
                                .font(.title2)
                                .bold()
                                .padding(.horizontal)
                            
                            let cuisines = Dictionary(grouping: networkManager.recipes, by: {$0.cuisine})
                            
                            // Grid for other cuisines
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                ForEach(cuisines.keys.sorted(), id: \.self) { cuisine in
                                    
                                    if let firstDish = cuisines[cuisine]?.first {
                                        NavigationLink(destination: CuisineDetailView(cuisine: cuisine, dishes: cuisines[cuisine] ?? [])) {
                                            CuisineCardView(cuisine: cuisine, imageURL: firstDish.photoURLSmall)
                                        }
                                    }
                                    
                                    
                                    // CuisineCardView()
                                    // Rectangle()
                                    // .frame(width: 150, height: 150)
                                    // .cornerRadius(10)
                                    // DishCardView()
                                }
                            }
                            .padding()
                        }
                    }
                    .refreshable {
                        print("Fetch refreshed")
                        networkManager.fetchRecipes()
                    }
                }
                
            }
            .toolbar(.hidden)
            .onAppear {
                print("Fetch called on appear")
                networkManager.fetchRecipes()
            }
        }
            
    }
}

#Preview {
    LandingView()
}
