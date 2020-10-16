//
//  DataSource.swift
//  EventCountdown
//
//  Created by Jerry Hanks on 15/10/2020.
//

import CoreData
import Foundation
import Resolver


//Remote + Local
protocol DataSource {
    ///The entity managed by the datasource
    associatedtype Entity
    
    
    /// Get an array of entities
    /// - Parameters:
    ///   - predicate: The predicate used forfetcing the entities
    ///   - sortDescriptors: The Sort descripto used for sorting the array of returned entities.
    func get(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Result<[Entity], Error>
    
    
    /// Create and return the create entity
    func create() -> Result<Entity, Error>
    
    
    /// Deletes an enritu
    /// - Parameter entity: The entity tio be deleted
    func delete(entity: Entity) -> Result<Bool, Error>
}

//Enum for CoreData Related Errors
enum CoreDataError: Error {
    case invalidManagedObjectType
}

//Local Event data source using CoreData
class EventsLocalDataSource<T: NSManagedObject>: DataSource {
    typealias Entity = T
    
    @Injected private
    var managedObejectContext: NSManagedObjectContext
    
    
    func get(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Result<[T], Error> {
        let fetchRequest = Entity.fetchRequest()
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        do {
            if let entities = try managedObejectContext.fetch(fetchRequest) as? [Entity] {
                return .success(entities)
            } else {
                return .failure(CoreDataError.invalidManagedObjectType)
            }
            
        } catch {
            return .failure(error)
        }
    }
    
    func create() -> Result<T, Error> {
        let enetityName = String(describing: Entity.self)
        
        guard let entity = NSEntityDescription.insertNewObject(forEntityName: enetityName, into: managedObejectContext) as? Entity else {
            return .failure(CoreDataError.invalidManagedObjectType)
        }
        
        return .success(entity)
    }
    
    func delete(entity: T) -> Result<Bool, Error> {
        managedObejectContext.delete(entity)
        return .success(true)
        
    }
    
    
}
