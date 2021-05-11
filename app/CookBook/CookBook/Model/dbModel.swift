//
//  dbModel.swift
//  firbaseSwiftProj
//
//  Created by Jainam, Himanshu, Ramy on 4/16/21.
//

import Foundation
import Firebase
import FirebaseStorage

class dbModel {
    var ref: DatabaseReference!
    var storage: Storage!
    var meals = [meal]()

    var imageUrl: String?
    var selectedMeal: meal?
    static var globalModel: dbModel?
    
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
                        self.imageUrl = (url?.absoluteString)!
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "imageUpload"), object: nil)
                    })
                }
                
            }
        }else{
            print("Failed to compress image")
        }
    }
    
    static func getModelInstance() -> dbModel{
        if let model = self.globalModel{
            return model
        }else{
            let newModel = dbModel()
            self.globalModel = newModel
            return newModel
        }
    }
    
    
    func addMeals(meal : meal) -> Void{
        print("________called addmeal------------")
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
    
    func setSelectedMeal(meal: meal) -> Void{
        self.selectedMeal = meal
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SelectedMealUpdated"), object: nil)
    }
    
    func getSelectedMeal() -> meal?{
        return self.selectedMeal
    }
    
    func getMeals() -> Void{
        self.meals = []
        ref.child("meals").observe(.value){ [self]snapshot in
            for child in snapshot.children{
                let mealObj = child as! DataSnapshot
                let mealDictionary = mealObj.value as! [String: String]
//                print("\n-----NEXT MEAL----------")
//                print("MealName: ", (mealDictionary["name"])!)
//                print("Meal Description: ", (mealDictionary["description"])!)
//                print("Meal image: ", mealDictionary["image"] ?? "")
                
                let newMeal = meal(name: (mealDictionary["name"])!, description: (mealDictionary["description"])!, imageData: (mealDictionary["image"]) ?? "", ingredients: (mealDictionary["ingredients"]) ?? "", directions: (mealDictionary["directions"]) ?? "", category: (mealDictionary["category"]) ?? "", prepTime: (mealDictionary["prepTime"]) ?? "")
                self.meals.append(newMeal)
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "mealArray"), object: nil)
        }
    }

}
