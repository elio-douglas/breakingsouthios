import SwiftUI
import SwiftData

struct ShoppingListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ShoppingItem.createdAt) private var items: [ShoppingItem]

    @State private var newItemName = ""

    private var toBuyItems: [ShoppingItem] {
        items.filter { !$0.isChecked }
    }

    private var completedItems: [ShoppingItem] {
        items.filter { $0.isChecked }
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        TextField("Add item...", text: $newItemName)
                            .onSubmit(addItem)

                        Button(action: addItem) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundStyle(.blue)
                        }
                        .disabled(newItemName.trimmingCharacters(in: .whitespaces).isEmpty)
                    }
                }

                if !toBuyItems.isEmpty {
                    Section("To Buy") {
                        ForEach(toBuyItems) { item in
                            ShoppingItemRow(item: item)
                        }
                        .onDelete(perform: deleteFromToBuy)
                    }
                }

                if !completedItems.isEmpty {
                    Section("Completed") {
                        ForEach(completedItems) { item in
                            ShoppingItemRow(item: item)
                        }
                        .onDelete(perform: deleteFromCompleted)
                    }
                }
            }
            .navigationTitle("Shopping List")
            .toolbar {
                if !completedItems.isEmpty {
                    Button("Clear Done") {
                        clearCompleted()
                    }
                }
            }
        }
    }

    private func addItem() {
        let trimmedName = newItemName.trimmingCharacters(in: .whitespaces)
        guard !trimmedName.isEmpty else { return }

        let item = ShoppingItem(name: trimmedName)
        modelContext.insert(item)
        newItemName = ""
    }

    private func deleteFromToBuy(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(toBuyItems[index])
        }
    }

    private func deleteFromCompleted(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(completedItems[index])
        }
    }

    private func clearCompleted() {
        for item in completedItems {
            modelContext.delete(item)
        }
    }
}

#Preview {
    ShoppingListView()
        .modelContainer(for: ShoppingItem.self, inMemory: true)
}
