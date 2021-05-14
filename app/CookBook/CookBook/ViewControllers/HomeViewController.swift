//
//  HomeViewController.swift
//  CookBook
//
//  Created by Jainam, Himanshu, Ramy on 4/21/21.
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
    var model: dbModel = dbModel.getModelInstance()
    var mealsFetched: [meal] = []
    
    @IBOutlet weak var cardTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.meals.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mealCardCell", for: indexPath) as? CardCell
        else{
            return UITableViewCell()
        };
        guard
            let defualtUIImg = UIImage(named: "icon1"),
            let defaultImg = defualtUIImg.jpegData(compressionQuality: 1)
        else {
            cell.configure(
                name: self.model.meals[indexPath.row].name,
                description: self.model.meals[indexPath.row].description,
                imgData: nil)
            return cell
        }
        
        var imgToBeSet: UIImage? = UIImage(data: defaultImg)
        do {
            if let url: URL = URL(string: self.model.meals[indexPath.row].imageData) {
                let data = try Data(contentsOf: url)
                imgToBeSet = UIImage(data: data)
            }
        } catch {}
        
        cell.configure(
            name: self.model.meals[indexPath.row].name,
            description: self.model.meals[indexPath.row].description,
            imgData: imgToBeSet)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.model.setSelectedMeal(meal: self.model.meals[indexPath.row])
        self.model.selectedMeal = self.model.meals[indexPath.row]
        performSegue(withIdentifier: "recipeSelected", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.getMeals()
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateMeals(_:)), name: NSNotification.Name(rawValue: "mealArray"), object: nil)
        
    }

    
    @objc func updateMeals(_ notification: NSNotification){
//        mealsFetched = model.meals
        self.cardTableView.reloadData()
    }

}

