//
//  AddRecipeViewController.swift
//  CookBook
//
//  Created by J on 4/28/21.
//

import UIKit

class AddRecipeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var directionsTextView: UITextView!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var prepTimeTextField: UITextField!
    
    
    
    let pickerData: [String] = ["Vegan", "Vegetarian", "Workout", "Daily", "Party", "Bulk"]

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
          // This method is triggered whenever the user makes a change to the picker selection.
          // The parameter named row and component represents what was selected.
      }
    
    @IBAction func addRecipeButtonClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryPicker.delegate = self
        self.categoryPicker.dataSource = self
        
        titleTextField.layer.borderColor = UIColor.gray.cgColor;
        titleTextField.layer.borderWidth = 1.0;
        titleTextField.layer.cornerRadius = 5.0;

        prepTimeTextField.layer.borderColor = UIColor.gray.cgColor;
        prepTimeTextField.layer.borderWidth = 1.0;
        prepTimeTextField.layer.cornerRadius = 5.0;
        
        descriptionTextView.layer.borderColor = UIColor.gray.cgColor;
        descriptionTextView.layer.borderWidth = 1.0;
        descriptionTextView.layer.cornerRadius = 5.0;

        ingredientsTextView.layer.borderColor = UIColor.gray.cgColor;
        ingredientsTextView.layer.borderWidth = 1.0;
        ingredientsTextView.layer.cornerRadius = 5.0;

        directionsTextView.layer.borderColor = UIColor.gray.cgColor;
        directionsTextView.layer.borderWidth = 1.0;
        directionsTextView.layer.cornerRadius = 5.0;
        
//        _ = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
    }
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }

}