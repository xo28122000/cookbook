//
//  DetailRecipeViewController.swift
//  CookBook
//
//  Created by J on 5/10/21.
//

import UIKit

class DetailRecipeViewController: UIViewController {
    var model: dbModel = dbModel.getModelInstance()
    var selectedMeal: meal?
    
    @IBOutlet weak var mealImageView: UIImageView!
    
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var directionsTextView: UITextView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var prepTimeLabel: UILabel!
    
    
    func updateView(){
        guard let selectedMealObj = self.selectedMeal
        else{
            return
        }
        mealNameLabel.text = selectedMealObj.name
        descriptionTextView.text = selectedMealObj.description
        ingredientsTextView.text = selectedMealObj.ingredients
        directionsTextView.text = selectedMealObj.directions
        categoryLabel.text = "Category: " + selectedMealObj.category
        prepTimeLabel.text = "⏲️: " + selectedMealObj.prepTime
//        mealImageView.image = get data from url // copy from cellCiew
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedMeal = self.model.getSelectedMeal()
        updateView()
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateSelectedMeals(_:)), name: NSNotification.Name(rawValue: "SelectedMealUpdated"), object: nil)
    }

    @objc func updateSelectedMeals(_ notification: NSNotification){
        self.selectedMeal = self.model.getSelectedMeal()
        updateView()
    }
}
