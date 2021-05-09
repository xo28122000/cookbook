//
//  HomeViewController.swift
//  CookBook
//
//  Created by J on 4/21/21.
//

import UIKit

struct meal{
    var name: String;
    var description: String;
    var imageData: String;
    var ingredients: String;
    var directions: String;
    var category: String;
    var prepTime: String;
}

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var model: dbModel = dbModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        model.getMeals(){
//            self.refreshTable()
//        }
        model.getMeals()
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateMeals(_:)), name: NSNotification.Name(rawValue: "mealArray"), object: nil)
        
    }

    
    @objc func updateMeals(_ notification: NSNotification){
        
        print("fetching all the meals", model.meals)
    }
    
    
    
    @IBOutlet weak var cardTableView: UITableView!
    
    let mealsFetched: [meal] = [
        meal(name: "name1", description: "Description1", imageData: imageStockString, ingredients: "", directions: "", category: "", prepTime: ""),
        meal(name: "name2", description: "Description2", imageData: imageStockString, ingredients: "", directions: "", category: "", prepTime: ""),
        meal(name: "name3", description: "Description3", imageData: imageStockString, ingredients: "", directions: "", category: "", prepTime: ""),
    ]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealsFetched.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mealCardCell", for: indexPath) as? CardCell
        else{
            return UITableViewCell()
        };
        
        cell.configure(
            name: mealsFetched[indexPath.row].name,
            description: mealsFetched[indexPath.row].description,
            imgData: mealsFetched[indexPath.row].imageData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
        mealsFetched[indexPath.row]
        performSegue(withIdentifier: "recipeSelected", sender: nil)
        // presentt new scewwn
        
    }

}

