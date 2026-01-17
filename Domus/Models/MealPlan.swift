import Foundation
import SwiftData

enum Weekday: Int, Codable, CaseIterable, Identifiable {
    case sunday = 0
    case monday = 1
    case tuesday = 2
    case wednesday = 3
    case thursday = 4
    case friday = 5
    case saturday = 6

    var id: Int { rawValue }

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

enum MealType: Int, Codable, CaseIterable, Identifiable {
    case breakfast = 0
    case lunch = 1
    case dinner = 2

    var id: Int { rawValue }

    var name: String {
        switch self {
        case .breakfast: return "Breakfast"
        case .lunch: return "Lunch"
        case .dinner: return "Dinner"
        }
    }

    var icon: String {
        switch self {
        case .breakfast: return "sun.rise"
        case .lunch: return "sun.max"
        case .dinner: return "moon.stars"
        }
    }
}

@Model
final class MealPlan {
    var id: UUID
    var weekdayRaw: Int
    var mealTypeRaw: Int
    var recipe: Recipe?

    var weekday: Weekday {
        get { Weekday(rawValue: weekdayRaw) ?? .sunday }
        set { weekdayRaw = newValue.rawValue }
    }

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
