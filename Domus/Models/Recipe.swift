import Foundation
import SwiftData

@Model
final class Recipe {
    var id: UUID
    var name: String
    var ingredients: [String]
    var createdAt: Date

    @Relationship(deleteRule: .nullify, inverse: \MealPlan.recipe)
    var mealPlans: [MealPlan]?

    init(name: String, ingredients: [String] = []) {
        self.id = UUID()
        self.name = name
        self.ingredients = ingredients
        self.createdAt = Date()
    }
}
