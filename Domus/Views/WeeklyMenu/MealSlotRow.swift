import SwiftUI
import SwiftData

struct MealSlotRow: View {
    @Bindable var mealPlan: MealPlan
    @State private var showingPicker = false

    var body: some View {
        Button {
            showingPicker = true
        } label: {
            HStack {
                Image(systemName: mealPlan.mealType.icon)
                    .foregroundStyle(.secondary)
                    .frame(width: 24)

                Text(mealPlan.mealType.name)
                    .foregroundStyle(.secondary)
                    .frame(width: 80, alignment: .leading)

                if let recipe = mealPlan.recipe {
                    Text(recipe.name)
                        .foregroundStyle(.primary)
                } else {
                    Text("Tap to add")
                        .foregroundStyle(.tertiary)
                        .italic()
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
        }
        .buttonStyle(.plain)
        .sheet(isPresented: $showingPicker) {
            RecipePickerView(mealPlan: mealPlan)
        }
    }
}
