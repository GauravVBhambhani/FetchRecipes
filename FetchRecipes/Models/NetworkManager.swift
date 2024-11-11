//
//  NetworkManager.swift
//  FetchRecipes
//
//  Created by Gaurav Bhambhani on 11/10/24.
//

import Foundation
import Combine

class NetworkManager: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var errorMessage: String? = nil

    private let allRecipesURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
    
//    private let malformedRecipesURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")!
//    private let emptyRecipesURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")!
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchRecipes() {
        session.dataTask(with: allRecipesURL) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = "Failed to load recipes: \(error.localizedDescription)"
                    self.recipes = []
                    return
                }
                
                guard let data = data else {
                    self.errorMessage = "Failed to load recipes: No data"
                    self.recipes = []
                    return
                }
                
                do {
                    let decodedResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
                    if decodedResponse.recipes.isEmpty {
                        self.errorMessage = "We're continuously fetching more recipes. Stay tuned!"
                        self.recipes = []
                    } else {
                        self.errorMessage = nil
                        self.recipes = decodedResponse.recipes
                    }
                    
                } catch {
                    self.errorMessage = "Failed to decode recipes"
                    self.recipes = []
                }
            }
        }.resume()
    }
}
