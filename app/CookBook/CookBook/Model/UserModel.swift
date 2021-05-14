//
//  UserModel.swift
//  CookBook
//
//  Created by Jainam, Himanshu, Ramy on 5/8/21.
//

import Foundation
import UIKit
import CoreData

class UserModel {
    // Lazy loading the swift way:
    var currentUser: UserItem?
    
    lazy var container: NSPersistentContainer = {
        var container =  NSPersistentContainer(name: "CookBook")
        container.loadPersistentStores { (_, error: Error?) in
            if let error = error {
                // You probably want to do some logging?
                fatalError("Something went wrong with the database")
            }
        }
        return container
    }()
    
    init() {
       
    }
    
    func getAllUsers(){
        //context for reading
        let context = container.viewContext
        
        
        // We are asking for all Users.
        let request = NSFetchRequest<NSManagedObject>(entityName: "User")
        
        do {
            let results: [NSManagedObject] = try context.fetch(request)
            
            let userItems: [UserItem] = results.compactMap { managedObject in
                return UserItem(managedObject: managedObject)
            }
            if let lastUser: UserItem = userItems.last {
                currentUser = lastUser
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "usersUpdated"), object: nil)
        } catch {
            print(error)
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "usersUpdated"), object: nil)
    }
    
    func storeNewUser(name: String){
        let user: UserItem = UserItem(name: name, uid: UUID().uuidString)
        let context = container.newBackgroundContext()
        guard let entity = NSEntityDescription.entity(forEntityName: "User", in: context) else {
            return
        }
        
        let managedObject = NSManagedObject(entity: entity, insertInto: context)

        managedObject.setValue(user.name, forKey: "name")
        managedObject.setValue(user.uid, forKey: "uid")
        
        do{
            try context.save()
        }catch{
            
        }
        currentUser = user
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "usersUpdated"), object: nil)

    }
}
