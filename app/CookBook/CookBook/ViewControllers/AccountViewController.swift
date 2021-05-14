//
//  AccountViewController.swift
//  CookBook
//
//  Created by Jainam, Himanshu, Ramy on 5/11/21.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var greetingLabel: UILabel!
    
    var users:[UserItem] = []
    let userModel: UserModel = UserModel()
    
    func updateGreeting(){
        if let currUser = self.userModel.currentUser {
            self.greetingLabel.text = "Hello " + currUser.name
        }else{
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // update greeting
        userModel.getAllUsers()
        updateGreeting()
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateUser(_:)), name: NSNotification.Name(rawValue: "usersUpdated"), object: nil)
    }
    @objc func updateUser(_ notification: NSNotification){
        updateGreeting()
    }

}
