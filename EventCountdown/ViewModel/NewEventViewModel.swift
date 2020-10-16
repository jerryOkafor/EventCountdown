//
//  NewEventViewModel.swift
//  EventCountdown
//
//  Created by Jerry Hanks on 11/10/2020.
//

import Combine
import CoreData
import Resolver

class NewEventViewModel: ObservableObject {
    //    private var viewContext: NSManagedObjectContext
    @LazyInjected
    var repository: EventDataStore
    

    func sayHello()  {
        print(repository.sayHello())
    }
    
    func saveEvent(title: String, date: Date, color: String) {

        
    }
    
}
