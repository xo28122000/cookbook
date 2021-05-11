//
//  User.swift
//  CookBook
//
//  Created by Jainam, Himanshu, Ramy on 5/8/21.
//

import Foundation
import CoreData

struct UserItem {
    let name: String
    var uid: String
}


// This is used to translate the NSManagedObjects to the UserItem to simplify access.
extension UserItem {
    init?(managedObject: NSManagedObject) {
        guard
            let name = managedObject.value(forKey: "name") as? String,
            let uid = managedObject.value(forKey: "uid") as? String
        else {
            return nil
        }
        self.name = name == "" ? "no name" : name
        self.uid = uid
    }
}
