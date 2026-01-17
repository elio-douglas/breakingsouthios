import SwiftUI
import SwiftData

struct AddRecipeView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var ingredientText = ""
    @State private var ingredients: [String] = []

    var body: some View {
        NavigationStack {
            Form {
                Section("Recipe Name") {
                    TextField("Enter recipe name", text: $name)
                }

                Section("Ingredients") {
                    HStack {
                        TextField("Add ingredient...", text: $ingredientText)
                            .onSubmit(addIngredient)

                        Button(action: addIngredient) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundStyle(.blue)
                        }
                        .disabled(ingredientText.trimmingCharacters(in: .whitespaces).isEmpty)
                    }

                    ForEach(ingredients, id: \.self) { ingredient in
                        Text(ingredient)
                    }
                    .onDelete(perform: deleteIngredient)
                }
            }
            .navigationTitle("New Recipe")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveRecipe()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }

    private func addIngredient() {
        let trimmed = ingredientText.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }
        ingredients.append(trimmed)
        ingredientText = ""
    }

    private func deleteIngredient(at offsets: IndexSet) {
        ingredients.remove(atOffsets: offsets)
    }

    private func saveRecipe() {
        let trimmedName = name.trimmingCharacters(in: .whitespaces)
        guard !trimmedName.isEmpty else { return }

        let recipe = Recipe(name: trimmedName, ingredients: ingredients)
        modelContext.insert(recipe)
        dismiss()
    }
}

#Preview {
    AddRecipeView()
        .modelContainer(for: Recipe.self, inMemory: true)
}
