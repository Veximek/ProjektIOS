//
//  Projekt_PatrykApp.swift
//  Projekt_Patryk
//
//  Created by Bartosz Skowyra on 13/06/2024.
//

import SwiftUI

@main
struct Projekt_PatrykApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
