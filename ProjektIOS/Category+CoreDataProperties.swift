//
//  Category+CoreDataProperties.swift
//  Projekt_Patryk
//
//  Created by Bartosz Skowyra on 13/06/2024.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var toRecipe: NSSet?

}

// MARK: Generated accessors for toRecipe
extension Category {

    @objc(addToRecipeObject:)
    @NSManaged public func addToToRecipe(_ value: Recipe)

    @objc(removeToRecipeObject:)
    @NSManaged public func removeFromToRecipe(_ value: Recipe)

    @objc(addToRecipe:)
    @NSManaged public func addToToRecipe(_ values: NSSet)

    @objc(removeToRecipe:)
    @NSManaged public func removeFromToRecipe(_ values: NSSet)

}

extension Category : Identifiable {

}
