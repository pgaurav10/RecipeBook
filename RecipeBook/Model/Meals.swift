//
//  Meals.swift
//  RecipeBook
//
//  Created by Gaurav Patil on 2/5/24.
//

import Foundation

struct Meals: Decodable {
    let meals: [Dessert]
}

struct Dessert: Decodable, Identifiable {
    var id: String {
        return idMeal
    }
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
