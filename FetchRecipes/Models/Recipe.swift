//
//  Recipe.swift
//  FetchRecipes
//
//  Created by Gaurav Bhambhani on 11/10/24.
//

import Foundation

struct Recipe: Identifiable, Codable {
    let id: UUID
    let cuisine: String
    let name: String
    let photoURLSmall: URL?
    let photoURLLarge: URL?
    let sourceURL: URL?
    let youtubeURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case cuisine, name
        case id = "uuid"
        case photoURLSmall = "photo_url_small"
        case photoURLLarge = "photo_url_large"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
}

struct RecipeResponse: Codable {
    let recipes: [Recipe]
}
