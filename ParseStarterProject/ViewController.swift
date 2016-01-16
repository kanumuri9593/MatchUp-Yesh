//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController {

    @IBAction func FBLoginButton(sender: AnyObject) {
        
        
        let permisssions = ["public_profile"]
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permisssions , block:{
            
            (user:PFUser?, error:NSError?) -> Void in
            
            if  error != nil {
                
                print(error.debugDescription)
                
            } else {
                if let user =  user {
                    
                    if let interestedInWomen = user["interestedInWomen"] {
                        
                         self.performSegueWithIdentifier("loguserin", sender: self)

                    
                    
                    
                    } else {
                    
                        self.performSegueWithIdentifier("ShowSignInScreen", sender: self)

                    
                    
                    }
                   
            }
                
            }
            
        })
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
  
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        /*
        let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackgroundWithBlock { (success, error) -> Void in
            print("Object has been saved.")
        }
       */
        
        
        
        
    }
    override func viewDidAppear(animated: Bool) {
        
        if let username = PFUser.currentUser()?.username {
            
            if let interestedInWomen = PFUser.currentUser()?["interestedInWomen"] {
                
                self.performSegueWithIdentifier("loguserin", sender: self)
                
            } else {
                
                self.performSegueWithIdentifier("ShowSignInScreen", sender: self)
                
            }
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

