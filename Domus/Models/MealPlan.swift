import Foundation
import SwiftData

/// Represents the days of the week for meal planning
/// Raw values align with Calendar's weekday numbering (0 = Sunday)
enum Weekday: Int, Codable, CaseIterable, Identifiable {
    case sunday = 0
    case monday = 1
    case tuesday = 2
    case wednesday = 3
    case thursday = 4
    case friday = 5
    case saturday = 6

    var id: Int { rawValue }

    /// Full name of the weekday (e.g., "Monday")
    var name: String {
        switch self {
        case .sunday: return "Sunday"
        case .monday: return "Monday"
        case .tuesday: return "Tuesday"
        case .wednesday: return "Wednesday"
        case .thursday: return "Thursday"
        case .friday: return "Friday"
        case .saturday: return "Saturday"
        }
    }

    /// Abbreviated weekday name (e.g., "Mon")
    var shortName: String {
        switch self {
        case .sunday: return "Sun"
        case .monday: return "Mon"
        case .tuesday: return "Tue"
        case .wednesday: return "Wed"
        case .thursday: return "Thu"
        case .friday: return "Fri"
        case .saturday: return "Sat"
        }
    }
}

/// Represents the type of meal for a given day
enum MealType: Int, Codable, CaseIterable, Identifiable {
    case breakfast = 0
    case lunch = 1
    case dinner = 2

    var id: Int { rawValue }

    /// Display name for the meal type
    var name: String {
        switch self {
        case .breakfast: return "Breakfast"
        case .lunch: return "Lunch"
        case .dinner: return "Dinner"
        }
    }

    /// SF Symbol icon name for the meal type
    var icon: String {
        switch self {
        case .breakfast: return "alarm"
        case .lunch: return "sun.max"
        case .dinner: return "moon.stars"
        }
    }
}

/// A SwiftData model representing a planned meal for a specific weekday and meal type
/// Links a Recipe to a particular day and meal slot in the weekly meal plan
@Model
final class MealPlan {
    var id: UUID
    var weekdayRaw: Int  // Stored as raw value for SwiftData compatibility
    var mealTypeRaw: Int  // Stored as raw value for SwiftData compatibility
    var recipe: Recipe?

    /// Computed property for type-safe weekday access
    var weekday: Weekday {
        get { Weekday(rawValue: weekdayRaw) ?? .sunday }
        set { weekdayRaw = newValue.rawValue }
    }

    /// Computed property for type-safe meal type access
    var mealType: MealType {
        get { MealType(rawValue: mealTypeRaw) ?? .breakfast }
        set { mealTypeRaw = newValue.rawValue }
    }

    init(weekday: Weekday, mealType: MealType, recipe: Recipe? = nil) {
        self.id = UUID()
        self.weekdayRaw = weekday.rawValue
        self.mealTypeRaw = mealType.rawValue
        self.recipe = recipe
    }
}
