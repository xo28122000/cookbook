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
        let url: URL? = URL(string: selectedMealObj.imageData)
        
        guard
            let defualtUIImg = UIImage(named: "icon1"),
            let defaultImg = defualtUIImg.jpegData(compressionQuality: 1)
        else {return}
        
        if let url: URL = url {
            let data = try? Data(contentsOf: url)
            mealImageView.image = UIImage(data: data ?? defaultImg)
        } else {
            mealImageView.image = UIImage(data: defaultImg)
        }
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
