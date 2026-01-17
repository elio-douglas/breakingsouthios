# Domus

A SwiftUI + SwiftData iOS meal planner app with three core features: Weekly Menu, Recipe Management, and Shopping List.

## Tech Stack

- **UI**: SwiftUI
- **Persistence**: SwiftData
- **Architecture**: Lightweight MVVM (using SwiftUI's `@Query` and `@Bindable` directly in views)
- **Minimum iOS**: 17.0

## Features

### Implemented

- **Weekly Menu** - 7 days × 3 meals grid with recipe assignment
- **Recipes** - CRUD (create, read, update, delete) with ingredients
- **Shopping List** - Add items, check off, sections, clear done

### Future Enhancements

**High Value:**

1. **Generate shopping list from meal plan** - Button to add all ingredients from the week's recipes to the shopping list
2. **Recipe instructions/steps** - Currently only has name + ingredients, no cooking directions
3. **Recipe search/filter** - Find recipes as the list grows

**Medium Value:**

4. **Recipe photos** - Add images to recipes
5. **Recipe categories/tags** - Organize by type (breakfast, vegetarian, quick, etc.)
6. **Serving size scaling** - Adjust ingredient quantities
7. **Duplicate ingredient handling** - Combine "2 eggs" + "3 eggs" into "5 eggs" in shopping list

**Nice to Have:**

8. **iCloud sync** - Sync across devices
9. **Share/export recipes** - Send recipes to friends
10. **Meal plan templates** - Save and reuse weekly plans
11. **Nutritional info** - Calories, macros, etc.
12. **Widget** - Show today's meals on home screen

## Project Structure

```
Domus/
├── DomusApp.swift              # Entry point + ModelContainer
├── Models/
│   ├── Recipe.swift
│   ├── MealPlan.swift          # + Weekday/MealType enums
│   └── ShoppingItem.swift
└── Views/
    ├── ContentView.swift       # TabView (Menu, Recipes, Shopping)
    ├── WeeklyMenu/
    │   ├── WeeklyMenuView.swift
    │   ├── MealSlotRow.swift
    │   └── RecipePickerView.swift
    ├── Recipes/
    │   ├── RecipesView.swift
    │   ├── RecipeDetailView.swift
    │   └── AddRecipeView.swift
    └── ShoppingList/
        ├── ShoppingListView.swift
        └── ShoppingItemRow.swift
```
