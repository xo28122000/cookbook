//
//  mealModel.swift
//  CookBook
//
//  Created by Jainam, Himanshu, Ramy on 5/6/21.
//

import Foundation
import UIKit
import CoreData

class mealModel {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func addRecipe(meal : meal) {
        
        //TODO: begin transaction
        //TODO: get context right
//        let newMeal = Meal(context: self.context)
//
//        context.insert(newMeal)
//        do{
//            try context.save()
//        }catch{
//            print(error)
//        }
        //
    }
    
    func getAllRecipes(_ title: String) {
        //TODO: begin transaction
        //TODO: get context right
        //TODO: convert from raw results to
        //list of Meal objects.
        do {
            let request: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Meal")
            
            let results = try context.fetch(request)
            
//            results.first
            
            print("results: " , results.first)
        }catch {
            print("fetch err: ", error)
        }

    }
}
