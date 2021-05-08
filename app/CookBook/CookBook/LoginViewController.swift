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
    var users:[UserItem] = []
    let userModel: UserModel = UserModel()
    
    //continueAsNewUserButton.setTitle("Continue As " + "xxxx", for: .normal)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUser()
        
        if(self.users.count > 0){
            continueAsNewUserButton.isHidden = true
            enterNameTextField.isHidden = true
        }else{
            continueAsExistingUserButton.isHidden = true;
        }
    }
    
    //Function to fetch the user from core data
    func getUser(){
        self.users = userModel.getAllUsers()
        
        guard let lastUser: UserItem = users.last else {
            print("users.last is seems to having trouble.")
            return
        }
        
        self.continueAsExistingUserButton.setTitle("Continue As " + lastUser.name, for: .normal)
        print("Continue As " + lastUser.name)
    }


    @IBAction func addUser(_ sender: Any) {
        
//        let newUser = User(context: self.context)
        
        guard let name = enterNameTextField.text else {
            //TODO handle error in UI
            print("User cannot have an empty name!")
            return
        }
        
        let uid = UUID().uuidString
        
        let newUser = UserItem(name: name, uid: uid)
        
        userModel.storeNewUser(user: newUser)
        self.users.append(newUser)
    }
}

