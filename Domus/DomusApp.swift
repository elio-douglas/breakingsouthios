import SwiftUI
import SwiftData

@main
struct DomusApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Recipe.self,
            MealPlan.self,
            ShoppingItem.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    initializeMealPlans()
                }
        }
        .modelContainer(sharedModelContainer)
    }

    private func initializeMealPlans() {
        let context = sharedModelContainer.mainContext
        let descriptor = FetchDescriptor<MealPlan>()

        do {
            let existingPlans = try context.fetch(descriptor)
            if existingPlans.isEmpty {
                for weekday in Weekday.allCases {
                    for mealType in MealType.allCases {
                        let mealPlan = MealPlan(weekday: weekday, mealType: mealType)
                        context.insert(mealPlan)
                    }
                }
                try context.save()
            }
        } catch {
            print("Failed to initialize meal plans: \(error)")
        }
    }
}
