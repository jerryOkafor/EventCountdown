//
//  Injection.swift
//  EventCountdown
//
//  Created by Jerry Hanks on 15/10/2020.
//

import Foundation
import Resolver
import CoreData

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register { CoreDataHelper.shared.container.viewContext as NSManagedObjectContext }
        register{EventsLocalDataSource()}
        register{EventRepository()}.implements(EventDataStore.self)
        register{NewEventViewModel()}
        
    }
}
