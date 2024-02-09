//
//  RecipeViewModel.swift
//  RecipeBook
//
//  Created by Gaurav Patil on 2/6/24.
//

import Foundation

class RecipeViewModel: ObservableObject {
    @Published var recipe: RecipeDetail?
    
    var apiService = ApiService()
    func fetchRecipeData(for id: String){
        
        apiService.fetchRecipeData(id: id) { result in
            switch result {
            case .success(let dataOf):
                self.recipe = dataOf.meals[0]
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
}
