import SwiftUI

struct RecipeDetailView: View {
    @ObservedObject var recipe: Recipe

    var body: some View {
        VStack(alignment: .leading) {
            if let imageData = recipe.image, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 200)
            }
            
            Text(recipe.name ?? "Unknown Recipe")
                .font(.title)
                .padding(.bottom, 5)
            
            Text("Czas przygotowania: \(recipe.preparationTime) minut")
                .padding(.bottom, 5)
            
            Text("Kategoria: \(recipe.category ?? "Unknown Category")")
                .padding(.bottom, 5)
            
            Text("Składniki")
                .font(.headline)
                .padding(.bottom, 2)
            
            Text(recipe.ingredients ?? "")
                .padding(.bottom, 5)
            
            Text("Instrukcje")
                .font(.headline)
                .padding(.bottom, 2)
            
            Text(recipe.instructions ?? "")
            
            Spacer()
        }
        .padding()
        .navigationTitle(recipe.name ?? "")
    }
}
