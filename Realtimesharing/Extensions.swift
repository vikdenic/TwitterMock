//
//  Extensions.swift
//  Realtimesharing
//
//  Created by Vik Denic on 1/29/16.
//  Copyright © 2016 nektar labs. All rights reserved.
//

import UIKit

extension UIAlertController {
    class func showAlert(title : String!, message : String!, viewController : UIViewController)
    {
        let alert : UIAlertController = UIAlertController(title: title,
            message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style:.Default, handler: nil))
        viewController.presentViewController(alert, animated: true, completion: nil)
    }

    class func showAlertWithError(error : NSError!, forVC : UIViewController)
    {
        let alert = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        alert.addAction(okAction)
        forVC.presentViewController(alert, animated: true, completion: nil)
    }
}