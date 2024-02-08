//
//  RecipeView.swift
//  RecipeBook
//
//  Created by Gaurav Patil on 2/5/24.
//

import SwiftUI

struct RecipeView: View {
    var id: String
    @ObservedObject var recipeVM = RecipeViewModel()
    
    var body: some View {
        NavigationView {
            if let safeRecipe = recipeVM.recipes {
                VStack {
                    HStack {
                        VStack {
                            Text(safeRecipe.str!)
                            Text(safeRecipe.youtube!)
                        }
                        Spacer()
                        AsyncImage(url: URL(string: safeRecipe.thumb!)) { image in
                            image.resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 50, alignment: .leading)
                            
                        } placeholder: {
                            ProgressView()
                        }
                        Spacer()
                    }
                    Spacer()
                    Text("Ingredients")
                    ScrollView {
                        if let ingr = safeRecipe.ingredients, let msrs = safeRecipe.measures {
                            ForEach(0..<min(ingr.count, msrs.count), id: \.self) { index in
                                let measureValue = msrs[index]
                                Text("\(ingr[index]): \(measureValue == " " ? "Depends" : measureValue)")
                            }
                        }
                    }
                    Spacer()
                    Text("Recipe")
                    ScrollView {
                        Text(safeRecipe.instructions!)
                            .padding()
                            .frame(maxWidth: .infinity)
                    }.frame(height: 400)
                        .padding(.bottom)
                }
            }
        }.task {
            recipeVM.fetchRecipeData(for: self.id)
        }
        .navigationBarTitle("Recipe")
    }
}

#Preview {
    RecipeView(id: "53049")
    
}
