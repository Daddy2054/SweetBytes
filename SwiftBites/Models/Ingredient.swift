//
//  Ingredient.swift
//  SwiftBites
//
//  Created by Jean on 04/09/24.
//

import Foundation
import SwiftData

@Model
final class Ingredient {
    @Attribute(.unique)
    let id: UUID
    @Attribute(.unique)
    var name: String
    
    init(id: UUID = UUID(), name: String = "") {
        self.id = id
        self.name = name
    }
}
