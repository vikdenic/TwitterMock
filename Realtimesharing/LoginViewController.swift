//
//  ViewController.swift
//  Realtimesharing
//
//  Created by Vik Denic on 1/29/16.
//  Copyright © 2016 nektar labs. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    var ref = Firebase(url: "https://realtimesocial.firebaseio.com/")

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: Actions
    @IBAction func onLoginTapped(sender: UIButton) {
        if emailTextField.text!.isEmpty && passwordTextField.text!.isEmpty {
            UIAlertController.showAlert("Empty fields", message: nil, viewController: self)
        } else {
            self.loginUser({ (authData) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            })
        }
    }

    @IBAction func onSignUpTapped(sender: UIButton) {
        if emailTextField.text!.isEmpty && passwordTextField.text!.isEmpty {
            UIAlertController.showAlert("Empty fields", message: nil, viewController: self)
        } else {
            ref.createUser(emailTextField.text, password: passwordTextField.text, withValueCompletionBlock: { (error: NSError!, result: [NSObject : AnyObject]!) -> Void in

                if error != nil {
                    UIAlertController.showAlertWithError(error, forVC: self)
                } else {
                    self.loginUser({ (authData) -> Void in
                        let userId = authData.uid
                        let newUser = [
                            "provider": authData.provider,
                            "email": authData.providerData["email"] as! String,
                            "posts" : ""
                        ]

                        let firstPost = [
                            "\(NSDate())": "My first post."
                        ]

                        self.ref.childByAppendingPath("users").childByAppendingPath(userId).setValue(newUser)
                        self.ref.childByAppendingPath("users/\(userId)/posts").setValue(firstPost)

                        self.dismissViewControllerAnimated(true, completion: nil)
                    })
                }
            })
        }
    }

    //MARK: Helpers
    func loginUser(completed: ((authData: FAuthData!) -> Void)?) {
        ref.authUser(emailTextField.text, password: passwordTextField.text, withCompletionBlock: { (error: NSError!, authData: FAuthData!) -> Void in
            if error != nil {
                UIAlertController.showAlertWithError(error, forVC: self)
            } else {
                print("login success")
                completed!(authData: authData)
            }
        })
    }
}


