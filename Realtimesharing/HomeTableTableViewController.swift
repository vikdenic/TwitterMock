//
//  HomeTableTableViewController.swift
//  Realtimesharing
//
//  Created by Vik Denic on 1/29/16.
//  Copyright © 2016 nektar labs. All rights reserved.
//

import UIKit
import Firebase

class HomeTableTableViewController: UITableViewController {

    var ref = Firebase(url: "https://realtimesocial.firebaseio.com/")
    var posts = [String : String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        if ref.authData == nil {
            print("not logged in")
            performSegueWithIdentifier("homeToLoginSegue", sender: self)
        } else {
            dataSetup()
            print("already logged in")
            print("ref.authData.uid: \(ref.authData.uid)")
            print("ref.authData.providerData: \(ref.authData.providerData)")
        }

        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.clearsSelectionOnViewWillAppear = true
    }

    func dataSetup() {
        ref.observeEventType(.Value) { (snapshot: FDataSnapshot!) -> Void in
            self.posts = snapshot.value.objectForKey("Posts") as! [String: String]
            self.tableView.reloadData()
        }
    }

    @IBAction func onLogoutTapped(sender: UIBarButtonItem) {
        ref.unauth()
        print("logged out")
        self.performSegueWithIdentifier("homeToLoginSegue", sender: self)
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell", forIndexPath: indexPath)
        let keys = Array(self.posts.keys)
        let post = posts[keys[indexPath.row]] as String! //Dictionaries have keys. 
                                                         //So we get the key from keys[indexPath.row]
                                                         //and access a post with its key
        cell.textLabel?.text = post
        return cell
    }
}
