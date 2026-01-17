import SwiftUI
import SwiftData

struct RecipeDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var recipe: Recipe

    @State private var isEditing = false
    @State private var editedName = ""
    @State private var editedIngredients: [String] = []
    @State private var newIngredient = ""

    var body: some View {
        Form {
            if isEditing {
                editingView
            } else {
                displayView
            }
        }
        .navigationTitle(isEditing ? "Edit Recipe" : recipe.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button(isEditing ? "Done" : "Edit") {
                if isEditing {
                    saveChanges()
                } else {
                    startEditing()
                }
            }
            .disabled(isEditing && editedName.trimmingCharacters(in: .whitespaces).isEmpty)
        }
    }

    @ViewBuilder
    private var displayView: some View {
        Section("Name") {
            Text(recipe.name)
        }

        Section("Ingredients (\(recipe.ingredients.count))") {
            if recipe.ingredients.isEmpty {
                Text("No ingredients added")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(recipe.ingredients, id: \.self) { ingredient in
                    HStack {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 6))
                            .foregroundStyle(.secondary)
                        Text(ingredient)
                    }
                }
            }
        }
    }

    @ViewBuilder
    private var editingView: some View {
        Section("Name") {
            TextField("Recipe name", text: $editedName)
        }

        Section("Ingredients") {
            HStack {
                TextField("Add ingredient...", text: $newIngredient)
                    .onSubmit(addIngredient)

                Button(action: addIngredient) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundStyle(.blue)
                }
                .disabled(newIngredient.trimmingCharacters(in: .whitespaces).isEmpty)
            }

            ForEach(editedIngredients, id: \.self) { ingredient in
                Text(ingredient)
            }
            .onDelete(perform: deleteIngredient)
        }
    }

    private func startEditing() {
        editedName = recipe.name
        editedIngredients = recipe.ingredients
        isEditing = true
    }

    private func saveChanges() {
        recipe.name = editedName.trimmingCharacters(in: .whitespaces)
        recipe.ingredients = editedIngredients
        isEditing = false
    }

    private func addIngredient() {
        let trimmed = newIngredient.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }
        editedIngredients.append(trimmed)
        newIngredient = ""
    }

    private func deleteIngredient(at offsets: IndexSet) {
        editedIngredients.remove(atOffsets: offsets)
    }
}
