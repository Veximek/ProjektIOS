//
//  Recipe+CoreDataProperties.swift
//  Projekt_Patryk
//
//  Created by Bartosz Skowyra on 13/06/2024.
//
//

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var name: String?
    @NSManaged public var ingredients: String?
    @NSManaged public var instructions: String?
    @NSManaged public var preparationTime: Int16
    @NSManaged public var category: String?
    @NSManaged public var image: Data?
    @NSManaged public var toCategory: Category?

}

extension Recipe : Identifiable {

}
