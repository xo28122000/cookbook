//
//  dbModel.swift
//  firbaseSwiftProj
//
//  Created by Ramy Fekry on 4/16/21.
//

import Foundation
import Firebase
import FirebaseStorage

class dbModel {
    var ref: DatabaseReference!
    var storage: Storage!
    var meals = [meal]()
    
    init() {
        ref = Database.database().reference()
        storage = Storage.storage()
    }
    
    func uploadImage(image: UIImage){
        let imageId = UUID().uuidString
        if let imageData = image.jpegData(compressionQuality: 1){
            let storageRef = storage.reference().child("images/\(imageId)")
            
            storageRef.putData(imageData, metadata: nil){(data, err) in
                if let err = err{
                    print("Error uploading image", err)
                }else{
                    print("Successfully uploaded image")
                    storageRef.downloadURL(completion: {url,error in
                        print("The url of the downloaded image is: " + (url?.absoluteString)!)
                    })
                }
            }
        }else{
            print("Failed to compress image")
        }
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
        ref.child("meals").observe(.value){ [self]snapshot in
            for child in snapshot.children{
                let mealObj = child as! DataSnapshot
                let mealDictionary = mealObj.value as! [String: String]
//                print("\n-----NEXT MEAL----------")
//                print("MealName: ", (mealDictionary["name"])!)
//                print("Meal Description: ", (mealDictionary["description"])!)
//                print("Meal uid: ", (mealDictionary["uid"])!)
                let newMeal = meal(name: (mealDictionary["name"])!, description: (mealDictionary["description"])!, imageData: "String", ingredients: "String", directions: "String", category: "String", prepTime: "")
                self.meals.append(newMeal)
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "mealArray"), object: nil)
        }
    }

}
