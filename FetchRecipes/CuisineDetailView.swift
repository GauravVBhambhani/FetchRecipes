//
//  CuisineDetailView.swift
//  FetchRecipes
//
//  Created by Gaurav Bhambhani on 11/10/24.
//

import SwiftUI

struct CuisineDetailView: View {
    let cuisine: String
    let dishes: [Recipe]
    
    var body: some View {
        List(dishes) { dish in
            NavigationLink(destination: DishDetailView(dish: dish)) {
                ListCardView(imageURL: dish.photoURLSmall, name: dish.name)
            }
            
        }
        
        .navigationTitle("\(cuisine) Dishes")
    }
}

//#Preview {
//    CuisineDetailView()
//}
