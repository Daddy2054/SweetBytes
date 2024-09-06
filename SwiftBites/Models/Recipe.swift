//
//  Recipèe.swift
//  SwiftBites
//
//  Created by Jean on 04/09/24.
//

import Foundation
import SwiftData

@Model
final class Recipe {
    var id: UUID
    @Attribute(.unique)
    var name: String
    var summary: String
    var category: RecipeCategory?
    var serving: Int
    var time: Int
    @Relationship(deleteRule: .cascade, inverse: \RecipeIngredient.recipe)
    var ingredients: [RecipeIngredient] = []
    var instructions: String
    var imageData: Data?
    
    init(
        id: UUID = UUID(),
        name: String = "",
        summary: String = "",
        category: RecipeCategory? = nil,
        serving: Int = 1,
        time: Int = 1,
        instructions: String = "",
        imageData: Data? = nil
    ) {
        self.id = id
        self.name = name
        self.summary = summary
        self.serving = serving
        self.time = time
        self.instructions = instructions
        self.imageData = imageData
        setCategory(category)
    }
    
    func setCategory(_ category: RecipeCategory?) {
        if let oldCategory = self.category {
            oldCategory.recipes.removeAll { $0.id == self.id }
        }
        self.category = category
        category?.recipes.append(self)
    }
    
    
}

extension Recipe {
    static func exists(withName name: String, excluding excludedID: UUID? = nil, in context: ModelContext) throws -> Bool {
        let nameDescriptor = FetchDescriptor<Recipe>(predicate: #Predicate<Recipe> { $0.name == name })
        let matchingRecipes = try context.fetch(nameDescriptor)
        
        if let excludedID = excludedID {
            return matchingRecipes.contains { $0.id != excludedID }
        } else {
            return !matchingRecipes.isEmpty
        }
    }
}
