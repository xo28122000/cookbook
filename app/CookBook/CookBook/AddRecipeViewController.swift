//
//  AddRecipeViewController.swift
//  CookBook
//
//  Created by J on 4/28/21.
//

import UIKit

class AddRecipeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var directionsTextView: UITextView!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var prepTimeTextField: UITextField!
    @IBOutlet weak var selectedImageView: UIImageView!
    let pickerData: [String] = ["Vegan", "Vegetarian", "Workout", "Daily", "Party", "Bulk"]
    var selectedCategory = ""
    let imagePicker = UIImagePickerController()
    var newMeal : meal?
    let dbmodel = dbModel()
    
    
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
        self.selectedCategory = pickerData[row]
      }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageView.image = pickedImage
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }

        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addRecipeButtonClick(_ sender: Any) {
        
        //guarding against user not entering title for recipe.
        guard
            let mealName: String = titleTextField.text,
            let mealDes: String = descriptionTextView.text,
            let ingredients = ingredientsTextView.text,
            let directions = directionsTextView.text,
            let prepTime = prepTimeTextField.text,
            let mealImage: UIImage = selectedImageView.image,
            let mealImagePngData = mealImage.pngData()
        else {
            let alert = UIAlertController(title: "Fill all required fields", message: "Please enter all fields in this form", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        let category = self.selectedCategory
        let mealImageString = mealImagePngData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        if(mealName.isEmpty || mealDes.isEmpty || ingredients.isEmpty || directions.isEmpty || prepTime.isEmpty || category.isEmpty){
            let alert = UIAlertController(title: "Fill all required fields", message: "Please enter all fields in this form", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        self.newMeal = meal(
            name: mealName,
            description: mealDes,
            imageData: "",
            ingredients: ingredients,
            directions: directions,
            category: category,
            prepTime: prepTime
        )
//        print(newMeal)
        dbmodel.uploadImage(image: mealImage)
        
    }
    
    @IBAction func selectImageButtonClick(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
               
        present(imagePicker, animated: true, completion: nil)

    }
    
    @objc func updateImageUrl(_ notification: NSNotification){
        //print("--------CAAALLLLLBACKKK---------------", self.dbmodel.imageUrl)
        guard
            var meal = self.newMeal,
            let imgUrl = self.dbmodel.imageUrl
        else {return}
        meal.imageData = imgUrl
        self.dbmodel.addMeals(meal: meal)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryPicker.delegate = self
        self.categoryPicker.dataSource = self
        
        imagePicker.delegate = self
        
        
        
        selectedCategory = self.pickerData[0]
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateImageUrl(_:)), name: NSNotification.Name(rawValue: "imageUpload"), object: nil)
        
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
