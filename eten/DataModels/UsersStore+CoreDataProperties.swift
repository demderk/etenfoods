//
//  UsersStore+CoreDataProperties.swift
//  eten
//
//  Created by Roman Zheglov on 08.12.2022.
//
//

import Foundation
import CoreData


extension UsersStore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UsersStore> {
        return NSFetchRequest<UsersStore>(entityName: "UsersStore")
    }

    @NSManaged public var userId: Int32
    @NSManaged public var username: String?
    @NSManaged public var email: String?

}

extension UsersStore : Identifiable {

}
