//
//  HomeViewController.swift
//  Realtimesharing
//
//  Created by Vik Denic on 1/29/16.
//  Copyright © 2016 nektar labs. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    var ref = Firebase(url: "https://realtimesocial.firebaseio.com/")

    override func viewDidLoad() {
        super.viewDidLoad()

        if ref.authData == nil {
            print("not logged in")
            performSegueWithIdentifier("homeToLoginSegue", sender: self)
        } else {
            print("already logged in")
        }
    }

    @IBAction func onLogoutTapped(sender: UIBarButtonItem) {
        ref.unauth()
        print("logged out")
        self.performSegueWithIdentifier("homeToLoginSegue", sender: self)
    }
}
