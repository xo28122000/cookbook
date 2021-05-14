//
//  ViewController.swift
//  CookBook
//
//  Created by Jainam, Himanshu, Ramy on 4/21/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var continueAsExistingUserButton: UIButton!
    @IBOutlet weak var enterNameTextField: UITextField!
    @IBOutlet weak var continueAsNewUserButton: UIButton!
    let userModel: UserModel = UserModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        userModel.getAllUsers()
        updateLoginOptions()
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateUser(_:)), name: NSNotification.Name(rawValue: "usersUpdated"), object: nil)
    }
    @objc func updateUser(_ notification: NSNotification){
        updateLoginOptions()
    }
    
    func updateLoginOptions(){
        if let currUser = self.userModel.currentUser {
            continueAsNewUserButton.isHidden = true
            enterNameTextField.isHidden = true
            continueAsExistingUserButton.isHidden = false;
            self.continueAsExistingUserButton.setTitle("Continue As " + currUser.name, for: .normal)
        }else{
            continueAsNewUserButton.isHidden = false
            enterNameTextField.isHidden = false
            continueAsExistingUserButton.isHidden = true;
        }
    }

    @IBAction func addUser(_ sender: Any) {
        guard
            let name: String = enterNameTextField.text,
            name != ""
        else {
            let alert = UIAlertController(title: "Name field is empty!", message: "Please enter a name to continue", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        userModel.storeNewUser(name: name)
    }
}

