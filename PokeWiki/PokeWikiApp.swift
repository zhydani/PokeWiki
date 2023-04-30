//
//  PokeWikiApp.swift
//  PokeWiki
//
//  Created by Zhydani Reis benigno  on 30/04/23.
//

import SwiftUI

@main
struct PokeWikiApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
