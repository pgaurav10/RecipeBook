//
//  MealsViewModel.swift
//  RecipeBook
//
//  Created by Gaurav Patil on 2/5/24.
//

import Foundation

class MealsViewModel: ObservableObject {
    @Published var desserts = [Dessert]()
    @Published var searchText: String = ""
    var apiService = ApiService()
    
    var filteredMeals: [Dessert] {
        guard !searchText.isEmpty else { return desserts }
        return desserts.filter { dessert in
            dessert.strMeal.lowercased().contains(searchText.lowercased())
        }
    }
    
    func fetchMealData() {
        apiService.fetchMealData() { result in
            switch result {
            case .success(let dataOf):
                self.desserts = dataOf.meals
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    
    
}
