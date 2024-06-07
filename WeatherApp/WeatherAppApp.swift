//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Lucas Gabriel Tais on 24/05/24.
//

import SwiftUI
import SwiftData

@main
struct WeatherAppApp: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
//            LocationListView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
//        .modelContainer(sharedModelContainer)
    }
}
