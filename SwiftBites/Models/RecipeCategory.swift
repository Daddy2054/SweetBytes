//
//  Category.swift
//  SwiftBites
//
//  Created by Jean on 04/09/24.
//

import Foundation
import SwiftData

@Model
final class RecipeCategory: Identifiable, Hashable {
    let id: UUID
    @Attribute(.unique)
    var name: String
    @Relationship(deleteRule: .nullify, inverse: \Recipe.category)
    var recipes: [Recipe]
    
    init(id: UUID = UUID(), name: String = "", recipes: [Recipe] = []) {
        self.id = id
        self.name = name
        self.recipes = recipes
    }
}
