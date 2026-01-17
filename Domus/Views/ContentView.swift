import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            WeeklyMenuView()
                .tabItem {
                    Label("Menu", systemImage: "calendar")
                }

            RecipesView()
                .tabItem {
                    Label("Recipes", systemImage: "book")
                }

            ShoppingListView()
                .tabItem {
                    Label("Shopping", systemImage: "cart")
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Recipe.self, MealPlan.self, ShoppingItem.self], inMemory: true)
}
