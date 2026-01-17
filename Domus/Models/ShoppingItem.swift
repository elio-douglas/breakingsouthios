import Foundation
import SwiftData

@Model
final class ShoppingItem {
    var id: UUID
    var name: String
    var isChecked: Bool
    var createdAt: Date

    init(name: String, isChecked: Bool = false) {
        self.id = UUID()
        self.name = name
        self.isChecked = isChecked
        self.createdAt = Date()
    }
}
