import SwiftUI

struct AddRecipeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode

    @State private var name: String = ""
    @State private var ingredients: String = ""
    @State private var instructions: String = ""
    @State private var preparationTime: Double = 5
    @State private var category: String = "Śniadanie"
    @State private var image: UIImage? = nil

    let categories = ["Śniadanie", "Obiad", "Kolacja", "Zupa"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Informacje podstawowe")) {
                    TextField("Nazwa", text: $name)
                    Picker("Kategoria", selection: $category) {
                        ForEach(categories, id: \.self) {
                            Text($0)
                        }
                    }
                    Slider(value: $preparationTime, in: 5...180, step: 5) {
                        Text("Czas przygotowania")
                    }
                    Text("Czas: \(Int(preparationTime)) minut")
                }

                Section(header: Text("Składniki")) {
                    TextEditor(text: $ingredients)
                }

                Section(header: Text("Instrukcje")) {
                    TextEditor(text: $instructions)
                }

                Section {
                    Button(action: {
                        imagePickerPresented.toggle()
                    }) {
                        Text("Dodaj zdjęcie")
                    }
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
            .navigationTitle("Nowy Przepis")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Zapisz") {
                        addRecipe()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Anuluj") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .sheet(isPresented: $imagePickerPresented) {
                ImagePicker(image: $image)
            }
        }
    }

    private func addRecipe() {
        let newRecipe = Recipe(context: viewContext)
        newRecipe.name = name
        newRecipe.ingredients = ingredients
        newRecipe.instructions = instructions
        newRecipe.preparationTime = Int16(preparationTime)
        newRecipe.category = category
        if let image = image, let imageData = image.pngData() {
            newRecipe.image = imageData
        }

        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}
