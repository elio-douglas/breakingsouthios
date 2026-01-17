import SwiftUI
import SwiftData

struct RecipePickerView: View {
    @Environment(\.dismiss) private var dismiss
    @Query(sort: \Recipe.name) private var recipes: [Recipe]

    @Bindable var mealPlan: MealPlan

    var body: some View {
        NavigationStack {
            Group {
                if recipes.isEmpty {
                    ContentUnavailableView {
                        Label("No Recipes", systemImage: "book.closed")
                    } description: {
                        Text("Add recipes in the Recipes tab first.")
                    }
                } else {
                    List {
                        Section {
                            Button {
                                mealPlan.recipe = nil
                                dismiss()
                            } label: {
                                HStack {
                                    Text("No Recipe")
                                        .foregroundStyle(.primary)
                                    Spacer()
                                    if mealPlan.recipe == nil {
                                        Image(systemName: "checkmark")
                                            .foregroundStyle(.blue)
                                    }
                                }
                            }
                        }

                        Section("Available Recipes") {
                            ForEach(recipes) { recipe in
                                Button {
                                    mealPlan.recipe = recipe
                                    dismiss()
                                } label: {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(recipe.name)
                                                .foregroundStyle(.primary)
                                            Text("\(recipe.ingredients.count) ingredient\(recipe.ingredients.count == 1 ? "" : "s")")
                                                .font(.caption)
                                                .foregroundStyle(.secondary)
                                        }
                                        Spacer()
                                        if mealPlan.recipe?.id == recipe.id {
                                            Image(systemName: "checkmark")
                                                .foregroundStyle(.blue)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Pick Recipe")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
    }
}
