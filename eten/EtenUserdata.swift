//
//  EtenUserdata.swift
//  eten
//
//  Created by Roman Zheglov on 08.12.2022.
//

import Foundation
import CoreData

struct EtenUserdata {
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "MainModel")
        
        container.loadPersistentStores{ dataDescription, error in
            if let coredataError = error {
                fatalError(coredataError.localizedDescription)
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func getAllUsers() -> [UsersStore] {
        let fetchRequest = UsersStore.fetchRequest()
        if let result = try? container.viewContext.fetch(fetchRequest) {
            return result
        }
        return []
    }
    
    func earseAllUsers() {
        for item in getAllUsers() {
            container.viewContext.delete(item)
        }
    }
    
    func registerCurrentUser(email: String) {
        let curentUser = UsersStore(context: container.viewContext)
        curentUser.email = email
        curentUser.userId = 1
        curentUser.username = "username"
        saveData()
    }
}
