//
//  Repository.swift
//  EventCountdown
//
//  Created by Jerry Hanks on 15/10/2020.
//

import Foundation
import Resolver

protocol DataStore {}

protocol EventDataStore: DataStore {
    func sayHello() -> String
}

protocol ItemDataStore: DataStore {}


//Events Repo that could have a number of events data sources
//Local or remote
class EventRepository: EventDataStore {
    
    @Injected
    var eventDataSource: EventsLocalDataSource
    
    //add another data source here
    
    func sayHello() -> String {
        return "Hello World"
    }
}

class ItemRespository: ItemDataStore {}
