import SwiftUI
import CoreData

struct RecipeListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Recipe.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Recipe.name, ascending: true)]
    ) private var recipes: FetchedResults<Recipe>
    
    @State private var showingAddRecipeView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(recipes) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        Text(recipe.name ?? "Unknown Recipe")
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                        Button {
                            // Handle delete action
                            viewContext.delete(recipe)
                            do {
                                try viewContext.save()
                            } catch {
                                print(error.localizedDescription)
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        
                        Button {
                            // Handle edit action
                            // Implement edit functionality here
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        .tint(.blue)
                    }
                }
            }
            .navigationTitle("Przepisy")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        showingAddRecipeView.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddRecipeView) {
                AddRecipeView()
                    .environment(\.managedObjectContext, viewContext)
            }
        }
    }
}
