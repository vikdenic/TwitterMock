//
//  NewPostTableViewController.swift
//  Realtimesharing
//
//  Created by Vik Denic on 1/29/16.
//  Copyright © 2016 nektar labs. All rights reserved.
//

import UIKit
import Firebase

class NewPostTableViewController: UITableViewController {

    @IBOutlet var submitButton: UIBarButtonItem!
    @IBOutlet var postTextField: UITextField!

    var ref = Firebase(url: "https://realtimesocial.firebaseio.com/")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        postTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
    }

    @IBAction func onCancelTapped(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onDoneTapped(sender: UIBarButtonItem) {
        ref.childByAppendingPath("Posts").childByAutoId().setValue(postTextField.text)
        ref.childByAppendingPath("users/\(ref.authData.uid)/post").childByAutoId().setValue(postTextField.text)
        dismissViewControllerAnimated(true, completion: nil)
    }

    func textFieldDidChange(textField: UITextField) {
        submitButton.enabled = !textField.text!.isEmpty
    }
}
