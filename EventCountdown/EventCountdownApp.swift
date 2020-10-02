//
//  EventCountdownApp.swift
//  EventCountdown
//
//  Created by Jerry Hanks on 02/10/2020.
//

import SwiftUI

@main
struct EventCountdownApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
