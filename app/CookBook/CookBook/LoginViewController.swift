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
        getUser()
        if(self.users != nil && self.users!.count > 0){
            continueAsNewUserButton.isHidden = true
            enterNameTextField.isHidden = true
        }else{
            continueAsExistingUserButton.isHidden = true;
        }
    }
    
    //Function to fetch the user from core data
    
    func getUser(){
        do{
            self.users = try context.fetch(User.fetchRequest())
            if(self.users != nil && self.users!.count > 0){
                DispatchQueue.main.async {
                    self.continueAsNewUserButton.setTitle("Continue As " + self.users![0].name!, for: .normal)
                }
                //continueAsNewUserButton.setTitle("Continue As " + self.users![0].name!, for: .normal)
            }
            //print(self.users![0].name)
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

