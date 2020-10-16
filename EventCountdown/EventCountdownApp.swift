//
//  EventCountdownApp.swift
//  EventCountdown
//
//  Created by Jerry Hanks on 02/10/2020.
//

import PartialSheet
import Resolver
import SwiftUI

@main
struct EventCountdownApp: App {
    let persistenceController = CoreDataHelper.shared
    
    @StateObject
    var sheetManager = PartialSheetManager()
    
    @Environment(\.scenePhase)
    private var scenePhase
    
    init() {
        try? self.persistenceController.setUp {
            //container set up
            print("Persistence container setup successfully!")
        }
    }
    

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(sheetManager)
        }.onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                print("Scene is now active")

            case .inactive:
                print("Scene is now inactive")
                
            case .background:
                print("Scene is now in background!")
                saveContext()
            
            @unknown default:
                print("Unknow scene phase must have been added")
            }
        }
        
    }
    
    func saveContext() {
        let context = persistenceController.container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        
    }
}
