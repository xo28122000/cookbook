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
    override func viewDidLoad() {
        super.viewDidLoad()
        continueAsExistingUserButton.isHidden = true;
       
    }


}

