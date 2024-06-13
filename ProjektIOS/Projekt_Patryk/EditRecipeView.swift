//
//  EditRecipeView.swift
//  Projekt_Patryk
//
//  Created by Bartosz Skowyra on 13/06/2024.
//
//
//import SwiftUI
//import CoreData
//
//struct EditRecipeView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @Environment(\.presentationMode) var presentationMode
//
//    @ObservedObject var recipe: Recipe
//
//    @State private var name: String = ""
//    @State private var ingredients: String = ""
//    @State private var instructions: String = ""
//    @State private var preparationTime: Double = 5
//    @State private var category: String = "Śniadanie"
//    @State private var image: UIImage? = nil
//    @State private var imagePickerPresented = false
//
//    let categories = ["Śniadanie", "Obiad", "Kolacja", "Zupa"]
//
//    init(recipe: Recipe) {
//        _recipe = ObservedObject(initialValue: recipe)
//        _name = State(initialValue: recipe.name ?? "")
//        _ingredients = State(initialValue: recipe.ingredients ?? "")
//        _instructions = State(initialValue: recipe.instructions ?? "")
//        _preparationTime = State(initialValue: Double(recipe.preparationTime))
//        _category = State(initialValue: recipe.category ?? "Śniadanie")
//        if let imageData = recipe.image {
//            _image = State(initialValue: UIImage(data: imageData))
//        }
//    }
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Informacje podstawowe")) {
//                    TextField("Nazwa", text: $name)
//                    Picker("Kategoria", selection: $category) {
//                        ForEach(categories, id: \.self) {
//                            Text($0)
//                        }
//                    }
//                    Slider(value: $preparationTime, in: 5...180, step: 5) {
//                        Text("Czas przygotowania")
//                    }
//                    Text("Czas: \(Int(preparationTime)) minut")
//                }
//
//                Section(header: Text("Składniki")) {
//                    TextEditor(text: $ingredients)
//                }
//
//                Section(header: Text("Instrukcje")) {
//                    TextEditor(text: $instructions)
//                }
//
//                Section {
//                    Button(action: {
//                        imagePickerPresented.toggle()
//                    }) {
//                        Text("Dodaj zdjęcie")
//                    }
//                    if let image = image {
//                        Image(uiImage: image)
//                            .resizable()
//                            .scaledToFit()
//                    }
//                }
//            }
//            .navigationTitle("Edytuj Przepis")
//            .toolbar {
//                ToolbarItem(placement: .confirmationAction) {
//                    Button("Zapisz") {
//                        saveRecipe()
//                    }
//                }
//                ToolbarItem(placement: .cancellationAction) {
//                    Button("Anuluj") {
//                        presentationMode.wrappedValue.dismiss()
//                    }
//                }
//            }
//            .sheet(isPresented: $imagePickerPresented) {
//                ImagePicker(image: $image)
//            }
//        }
//    }
//
//    private func saveRecipe() {
//        recipe.name = name
//        recipe.ingredients = ingredients
//        recipe.instructions = instructions
//        recipe.preparationTime = Int16(preparationTime)
//        recipe.category = category
//        if let image = image, let imageData = image.pngData() {
//            recipe.image = imageData
//        }
//
//        do {
//            try viewContext.save()
//            presentationMode.wrappedValue.dismiss()
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//}

import SwiftUI
import CoreData

struct EditRecipeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Recipe.name, ascending: true)], animation: .default)
        private var recipes: FetchedResults<Recipe>
        
        

    var recipe: Recipe

    @State var editName: String = ""
    @State var editIngredients: String = ""
    @State var editInstructions: String = ""
    @State var editPreparationTime: Double = 5
    @State var editCategory: String = "Śniadanie"
    @State var editImage: UIImage? = nil
    @State private var imagePickerPresented = false

    let categories = ["Śniadanie", "Obiad", "Kolacja", "Zupa"]

    var body: some View {
        VStack {
            TextField("Nazwa", text: $editName)
                .padding()
            Picker("Kategoria", selection: $editCategory) {
                ForEach(categories, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            Slider(value: $editPreparationTime, in: 5...180, step: 5) {
                Text("Czas przygotowania")
            }
            Text("Czas: \(Int(editPreparationTime)) minut")
                .padding()
            TextField("Składniki", text: $editIngredients)
                .padding()
            TextField("Instrukcje", text: $editInstructions)
                .padding()
            
            Button(action: {
                imagePickerPresented.toggle()
            }) {
                Text("Dodaj zdjęcie")
            }
            .padding()
            if let editImage = editImage {
                Image(uiImage: editImage)
                    .resizable()
                    .scaledToFit()
            }
            Button(action: {
                saveRecipe()
            }) {
                Text("Edytuj")
            }
            .padding()
        }
        .onAppear {
            loadRecipeData()
        }
        .sheet(isPresented: $imagePickerPresented) {
            ImagePicker(image: $editImage)
        }
    }

    private func loadRecipeData() {
        editName = recipe.name ?? ""
        editIngredients = recipe.ingredients ?? ""
        editInstructions = recipe.instructions ?? ""
        editPreparationTime = Double(recipe.preparationTime)
        editCategory = recipe.category ?? "Śniadanie"
        if let imageData = recipe.image {
            editImage = UIImage(data: imageData)
        }
    }

    private func saveRecipe() {
        recipe.name = editName
        recipe.ingredients = editIngredients
        recipe.instructions = editInstructions
        recipe.preparationTime = Int16(editPreparationTime)
        recipe.category = editCategory
        if let editImage = editImage, let imageData = editImage.pngData() {
            recipe.image = imageData
        }

        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
