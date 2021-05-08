//
//  dbModel.swift
//  firbaseSwiftProj
//
//  Created by Ramy Fekry on 4/16/21.
//

import Foundation
import Firebase
//import FirebaseFirestore



/**
 If you run the app you should see the output of the demo code in the bottom.
 This all is demoed in the LoginViewController.swift > TESTING_RUN()
 */
class dbModel {
    var ref: DatabaseReference!
    var users = [AuthorOfMeal]()
    
    init?() {
        ref = Database.database().reference()
    }
    
    //used to register a user in firebase.
    func setUserValue(uid: String, username: String) -> Void {
        
        ref.child("/users/\(uid)").setValue([
            "username": username
        ])
    }
    
    
    func addMeals(meal : meal) -> Void{
        let newMeal = [
            "uid" : UUID().uuidString,
            "name": meal.name,
            "description": meal.description,
            "image": meal.imageData,
            "ingredients": meal.ingredients,
            "directions" : meal.directions,
            "category" : meal.category,
            "prepTime" : meal.prepTime
        ]
        let uuid = UUID().uuidString
       ref.child("meals/\(uuid)").setValue(newMeal)
    }
    
    //gets a list of users from the database.
//    func getAllUsers() -> Any? {
//        var result: Any?
//
//        ref.child("users").getData() { (error, snapshot) in
//            if let error = error {
//                print("Error getting data \(error)")
//                result = nil
//            }
//            else if snapshot.exists() {
//                print("Got data \(snapshot.value as! NSDictionary)")
//                result = snapshot.value
//            }
//            else {
//                print("No data available")
//                result = nil
//            }
//        }
//
//        return result
//    }
       
    func getMeals() -> Void{
        ref.child("meals").observe(.value){snapshot in
            for child in snapshot.children{
                let mealObj = child as! DataSnapshot
                let mealDictionary = mealObj.value as! [String: String]
                print("\n-----NEXT MEAL----------")
                print("MealName: ", (mealDictionary["name"])!)
                print("Meal Description: ", (mealDictionary["description"])!)
                print("Meal uid: ", (mealDictionary["uid"])!)
                
            }
        }
    }

    func getAllTheUsers(){
        ref.child("users").observe(.value){ snapshot in
            for child in snapshot.children {
                let obj = child as! DataSnapshot
                let userDictionary = obj.value as! [String: String]
                print("loop username", (userDictionary["username"])!)
            }
        }
    }
    
    //gets one specific user's info.
    func getUserBy(uid: String) -> Any? {
        var result: Any?
        var name: String = ""
        
        self.ref.child("users").child(uid).observe(DataEventType.value, with: {(snapshot) in
            if let dictionary = snapshot.value as? [String: String] {
                name = (dictionary["username"])!
                print("Printing dictionary", name)
            
            }
        })
        
        
        print("The string fetch is ", name)
        return result
        
    }
}
