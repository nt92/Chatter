//
//  ViewController.swift
//  Chatter
//
//  Created by Nikhil Thota on 2/2/16.
//  Copyright © 2016 Nikhil Thota. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onSignUp(sender: AnyObject) {
        let user = PFUser()
        user.username = userNameField.text
        user.password = passwordField.text
        user.email = userNameField.text
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                print(error.description)
            } else {
                self.performSegueWithIdentifier("gotoChat", sender: self)
            }
        }
    }
    
    
    @IBAction func onLogin(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(userNameField.text!, password: passwordField.text!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                self.performSegueWithIdentifier("gotoChat", sender: self)
            } else {
                print(error?.description)
            }
        }
    }
}

