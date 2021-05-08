//
//  dbModel.swift
//  firbaseSwiftProj
//
//  Created by Ramy Fekry on 4/16/21.
//

import Foundation
import Firebase


class dbModel {
    var ref: DatabaseReference!
    var meals = [meal]()
    
    init?() {
        ref = Database.database().reference()
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

       
    func getMeals() -> Void{
        ref.child("meals").observe(.value){snapshot in
            for child in snapshot.children{
                let mealObj = child as! DataSnapshot
                let mealDictionary = mealObj.value as! [String: String]
                print("\n-----NEXT MEAL----------")
                print("MealName: ", (mealDictionary["name"])!)
                print("Meal Description: ", (mealDictionary["description"])!)
                print("Meal uid: ", (mealDictionary["uid"])!)
                let newMeal = meal(name: (mealDictionary["name"])!, description: (mealDictionary["description"])!, imageData: "String", ingredients: "String", directions: "String", category: "String", prepTime: "")
                self.meals.append(newMeal)
            }
        }
    }

}
