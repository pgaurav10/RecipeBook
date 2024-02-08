//
//  MealsView.swift
//  RecipeBook
//
//  Created by Gaurav Patil on 2/5/24.
//

import SwiftUI

struct MealsView: View {
    @ObservedObject var mealsVM = MealsViewModel()
    
    var body: some View {
        NavigationView {
            List{
                ForEach(mealsVM.filteredMeals) { dessert in
                    NavigationLink(destination: RecipeView(id: dessert.id)) {
                        HStack {
                            AsyncImage(url: URL(string: dessert.strMealThumb)) { image in
                                image.resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 50, alignment: .leading)
                            } placeholder: {
                                //put your placeholder here
                                ProgressView()
                            }
    
                            Text(dessert.strMeal)
                        }
                    }
                }
            }
            .navigationTitle("Desserts")
            .searchable(text: $mealsVM.searchText)
        }.onAppear(perform: self.mealsVM.fetchMealData)
            
    }
}

#Preview {
    MealsView()
}
