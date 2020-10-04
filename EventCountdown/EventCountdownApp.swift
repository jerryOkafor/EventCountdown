//
//  EventCountdownApp.swift
//  EventCountdown
//
//  Created by Jerry Hanks on 02/10/2020.
//

import PartialSheet
import SwiftUI

@main
struct EventCountdownApp: App {
    let persistenceController = PersistenceController.shared
    let sheetManager = PartialSheetManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(sheetManager)
        }
    }
}
