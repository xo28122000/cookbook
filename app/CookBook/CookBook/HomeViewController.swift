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
    var mealsFetched: [meal] = []
    
    @IBOutlet weak var cardTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealsFetched.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mealCardCell", for: indexPath) as? CardCell
        else{
            return UITableViewCell()
        };
        print("connfigure: ", mealsFetched[indexPath.row].name)
        cell.configure(
            name: mealsFetched[indexPath.row].name,
            description: mealsFetched[indexPath.row].description,
            imgData: mealsFetched[indexPath.row].imageData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        mealsFetched[indexPath.row]
        performSegue(withIdentifier: "recipeSelected", sender: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        model.getMeals()
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateMeals(_:)), name: NSNotification.Name(rawValue: "mealArray"), object: nil)
        
    }

    
    @objc func updateMeals(_ notification: NSNotification){
        mealsFetched = model.meals
        self.cardTableView.reloadData()
    }

}

