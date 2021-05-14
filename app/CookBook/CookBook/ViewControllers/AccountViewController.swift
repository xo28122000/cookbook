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
        self.users = userModel.getAllUsers()
        
        guard let lastUser: UserItem = users.last else {
            return
        }
        
        self.greetingLabel.text = "Hello " + lastUser.name
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // update greeting
        updateGreeting()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
