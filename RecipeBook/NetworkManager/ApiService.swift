//
//  ApiService.swift
//  RecipeBook
//
//  Created by Gaurav Patil on 2/7/24.
//

import Foundation

class ApiService {
    
    func fetchMealData(completion: @escaping (Result<Meals,Error>) -> Void ) {
        if let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let e = error {
                    print(e.localizedDescription)
                    return
                }
                
                if let safeData = data {
                    let decoder = JSONDecoder()
                    do {
                        let result = try decoder.decode(Meals.self, from: safeData)
                        DispatchQueue.main.async {
                            completion(.success(result))
                        }
                        
                    } catch {
                        completion(.failure(error))
                    }
                    
                }
            }
            
            task.resume()
        }
    }
    
    func fetchRecipeData(id: String, completion: @escaping (Result<Recipe,Error>) -> Void) {
        let dessertLink = "https://themealdb.com/api/json/v1/1/lookup.php?i="+id
        
    
        if let url = URL(string: dessertLink) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let e = error {
                    print(e.localizedDescription)
                    completion(.failure(e))
                    return
                }
                
                if let safeData = data {
                    let decoder = JSONDecoder()
                    do {
                        
                        let result = try decoder.decode(Recipe.self, from: safeData)
                        DispatchQueue.main.async {
                            completion(.success(result))
                        }
                        
                    } catch {
                        print(error)
                        completion(.failure(error))
                    }
                    
                }
            }
            
            task.resume()
        }
    }
}
