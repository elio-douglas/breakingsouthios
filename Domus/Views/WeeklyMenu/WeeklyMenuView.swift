import SwiftUI
import SwiftData

struct WeeklyMenuView: View {
    @Query(sort: [
        SortDescriptor(\MealPlan.weekdayRaw),
        SortDescriptor(\MealPlan.mealTypeRaw)
    ]) private var mealPlans: [MealPlan]

    var body: some View {
        NavigationStack {
            List {
                ForEach(Weekday.allCases) { weekday in
                    Section(weekday.name) {
                        ForEach(mealsFor(weekday: weekday)) { mealPlan in
                            MealSlotRow(mealPlan: mealPlan)
                        }
                    }
                }
            }
            .navigationTitle("Weekly Menu")
        }
    }

    private func mealsFor(weekday: Weekday) -> [MealPlan] {
        mealPlans.filter { $0.weekday == weekday }
            .sorted { $0.mealType.rawValue < $1.mealType.rawValue }
    }
}

#Preview {
    WeeklyMenuView()
        .modelContainer(for: [MealPlan.self, Recipe.self], inMemory: true)
}
