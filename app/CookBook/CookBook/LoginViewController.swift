//
//  ViewController.swift
//  CookBook
//
//  Created by J on 4/21/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var continueAsExistingUserButton: UIButton!
    @IBOutlet weak var enterNameTextField: UITextField!
    @IBOutlet weak var continueAsNewUserButton: UIButton!
    var users:[User]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // try to retrive user object from local core data
        // if user continueAsExistingUserButton
        // else enterNameTextField & continueAsNewUserButton
        continueAsExistingUserButton.isHidden = true;
    }
    
    //Function to fetch the user from core data
    
    func getUser(){
        do{
            self.users = try context.fetch(User.fetchRequest())
        }
        catch{
            
        }
    }


    @IBAction func addUser(_ sender: Any) {
        let newUser = User(context: self.context)
        newUser.name = enterNameTextField.text
        newUser.uid = UUID().uuidString
        
        do{
            try self.context.save()
        }catch{
            
        }
    }
}

