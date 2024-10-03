//
//  RecipeIngredient.swift
//  SwiftBites
//
//  Created by Jean on 04/09/24.
//

import Foundation
import SwiftData

@Model
final class RecipeIngredient {
    @Attribute(.unique)
    let id: UUID
    @Relationship    (deleteRule: .nullify)
    var ingredient: Ingredient?
    var quantity: String
    @Relationship(inverse: \Recipe.ingredients)
    private(set) var recipe: Recipe?
    
    init(
        id: UUID = UUID(),
        ingredient: Ingredient,
        quantity: String = "",recipe: Recipe? = nil    ) {
            self.id = id
            self.quantity = quantity
            setRecipe(recipe)
            setIngredient(ingredient)
        }
    
    func setIngredient(_ ingredient: Ingredient?) {
        self.ingredient = ingredient
    }
    
    func setRecipe(_ recipe: Recipe?) {
        self.recipe = recipe
    }
}
