//
//  CoreDataHelper.swift
//  Map Kit Example
//
//  Created by fatih.sukran on 27.09.2023.
//

import Foundation
import CoreData
import UIKit

class CoreDataHelper<T: NSManagedObject> {
    private let context: NSManagedObjectContext
    
    let entitiyName: String
    
    init(entitiyName: String) {
        self.entitiyName = entitiyName
        self.context = Self.getManagedObjectContext()!
    }
    
    static func getManagedObjectContext() -> NSManagedObjectContext? {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate?.persistentContainer.viewContext
    }
    
    static func getFetchRequest(_ entityName: String) -> NSFetchRequest<NSFetchRequestResult>? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false
        return fetchRequest
    }
    
    func get(id: UUID) -> T? {
        let predicate = NSPredicate(format: "id = %@", id.uuidString)
        
        return get(predicate: predicate).first
    }
    
    func get(predicate: NSPredicate) -> [T] {
        let fetchRequest = Self.getFetchRequest(entitiyName)!
        fetchRequest.predicate = predicate
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.first as! [T]
        } catch {
            print("Error in CoreDataHelper.get()")
        }
        
        return []
    }
    
    func getAll() -> [T] {
        let fetchRequest = Self.getFetchRequest(entitiyName)!
        do {
            let results = try context.fetch(fetchRequest)
            return results as! [T]
        } catch {
            print("Error")
        }
        
        return []
    }
    
    func add(item: T) {
        context.insert(item)
        do {
            try context.save()
        } catch {
            print("Error Core Data Helper::Add")
        }
    }
}
