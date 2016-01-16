//
//  SwipingViewController.swift
//  Tinder
//
//  Created by Yeswanth varma Kanumuri on 1/15/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class SwipingViewController: UIViewController {

    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    
    var displayedUserId = ""
    
    
    func wasDragged(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translationInView(self.view)
        let label = gesture.view!
        
        label.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y)
        
        let xFromCenter = label.center.x - self.view.bounds.width / 2
        
        let scale = min(100 / abs(xFromCenter), 1)
        
        
        var rotation = CGAffineTransformMakeRotation(xFromCenter / 200)
        
        var stretch = CGAffineTransformScale(rotation, scale, scale)
        
        label.transform = stretch
        
        
        if gesture.state == UIGestureRecognizerState.Ended {
            
            var acceptedOrRejected = ""
            
            if label.center.x < 100 {
                
                acceptedOrRejected = "Rejected"
                
            } else if label.center.x > self.view.bounds.width - 100 {
                
                acceptedOrRejected = "Accepted"
                
            }
            
            if acceptedOrRejected != "" {
                
                PFUser.currentUser()?.addUniqueObjectsFromArray([displayedUserId], forKey:acceptedOrRejected)
                
                PFUser.currentUser()?.saveInBackground()
                
            }
            
            rotation = CGAffineTransformMakeRotation(0)
            
            stretch = CGAffineTransformScale(rotation, 1, 1)
            
            label.transform = stretch
            
            label.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
            
            updateImage()
            
        }
        
        
        
    }
    
    
    func updateImage() {
        
        var query = PFUser.query()!
        
        var interestedIn = "male"
        
        if PFUser.currentUser()!["interestedInWomen"]! as! Bool == true {
            
            interestedIn = "female"
            
        }
        
        var isFemale = true
        
        if PFUser.currentUser()!["gender"]! as! String == "male" {
            
            isFemale = false
            
        }
        
        query.whereKey("gender", equalTo:interestedIn)
        query.whereKey("interestedInWomen", equalTo: isFemale)
        var ignoredUsers = [""]
        
        if let acceptedUsers = PFUser.currentUser()?["Accepted"]  {
            
            ignoredUsers += acceptedUsers as! Array
            
        }
        
        if let rejectedUsers = PFUser.currentUser()?["Rejected"] {
            
            ignoredUsers += rejectedUsers as! Array
            
        }
        
        
        query.whereKey("objectId", notContainedIn: ignoredUsers)
        
        query.whereKey("location", withinGeoBoxFromSouthwest:PFGeoPoint(latitude:0, longitude:0), toNortheast:PFGeoPoint(latitude:5, longitude:5))
        
        
        query.limit = 1
        
  
        
        query.findObjectsInBackgroundWithBlock {
            (objects, error: NSError?) -> Void in
            
            if error != nil {
                
                print(error)
                
            } else if let objects = objects as? [PFObject] {
                
                for object in objects {
                    
                    print(object)
                    
                    self.displayedUserId = object.objectId!
                    
                    let imageFile = object["image"] as! PFFile
                    
                    imageFile.getDataInBackgroundWithBlock {
                        (imageData: NSData?, error: NSError?) -> Void in
                        
                        if error != nil {
                            
                            print(error)
                            
                        } else {
                            
                            if let data = imageData {
                                
                                self.userImg.image = UIImage(data: data)
                                
                            }
                            
                            
                        }
                        
                        
                    }
                    
                }
                
                
            }
            
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UIPanGestureRecognizer(target: self, action: Selector("wasDragged:"))
        userImg.addGestureRecognizer(gesture)
        
        userImg.userInteractionEnabled = true
        
        updateImage()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "logOut" {
        
        PFUser.logOut()
        }
        
        
        
            }
   

}
