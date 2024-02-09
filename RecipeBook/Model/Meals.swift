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
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    
    // Define custom CodingKeys to handle dynamic ingredient keys
    private enum CodingKeys: String, CodingKey {
        
        case idMeal = "idMeal"
        case strMeal  = "strMeal"
        case strMealThumb = "strMealThumb"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        idMeal = try values.decodeIfPresent(String.self, forKey: .idMeal) ?? ""
        strMeal = try values.decodeIfPresent(String.self, forKey: .strMeal) ?? "N/A"
        strMealThumb = try values.decodeIfPresent(String.self, forKey: .strMealThumb) ?? ""
    }
}
