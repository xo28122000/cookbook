//
//  User+CoreDataProperties.swift
//  
//
//  Created by Jainam, Himanshu, Ramy on 5/1/21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var uid: String?

}
