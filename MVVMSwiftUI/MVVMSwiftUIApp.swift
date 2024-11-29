//
//  MVVMSwiftUIApp.swift
//  MVVMSwiftUI
//
//  Created by Pagotto, Paola Fagundes on 15/04/2024.
//

// https://www.youtube.com/watch?v=mS6Tj1I9Gto

import SwiftUI
import SwiftData

@main
struct MVVMSwiftUIApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
