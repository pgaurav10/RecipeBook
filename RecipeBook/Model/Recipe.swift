//
//  Recipe.swift
//  RecipeBook
//
//  Created by Gaurav Patil on 2/5/24.
//

import Foundation

struct Recipe: Decodable {
    let meals: [RecipeDetail]
}

struct RecipeDetail: Decodable {
    
    let idMeal: String?
    let str: String?
    let instructions: String?
    let thumb: String?
    let youtube: String?
    
    var ingredients: [String]? = []
    var measures: [String]? = []


    
    // Define custom CodingKeys to handle dynamic ingredient keys
    private enum CodingKeys: String, CodingKey {
        
        case idMeal = "idMeal"
        case str  = "strMeal"
        case thumb = "strMealThumb"
        case instructions = "strInstructions"
        case youtube = "strYoutube"
        
    }
    
    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        idMeal = try values.decodeIfPresent(String.self, forKey: .idMeal) ?? ""
        str = try values.decodeIfPresent(String.self, forKey: .str) ?? "N/A"
        instructions = try values.decodeIfPresent(String.self, forKey: .instructions) ?? "N/A"
        thumb = try values.decodeIfPresent(String.self, forKey: .thumb) ?? ""
        youtube = try values.decodeIfPresent(String.self, forKey: .youtube) ?? "N/A"

        // Dynamically decode ingredients and measures
        
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var ingredientsArray: [String] = []
        var measuresArray: [String] = []

        
        for key in container.allKeys {
            if key.stringValue.hasPrefix("strIngredient"), let ingredient = try container.decodeIfPresent(String.self, forKey: key), !ingredient.isEmpty {
                
                ingredientsArray.append(ingredient)
            }

            if key.stringValue.hasPrefix("strMeasure"), let measure = try container.decodeIfPresent(String.self, forKey: key), !measure.isEmpty {
                measuresArray.append(measure)
            }
        }
        
        
        ingredients = ingredientsArray
        measures = measuresArray
    }
    
}
