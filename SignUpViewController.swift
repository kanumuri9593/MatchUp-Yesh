//
//  SignUpViewController.swift
//  Tinder
//
//  Created by Yeswanth varma Kanumuri on 1/15/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var UserImage: UIImageView!
    
    @IBOutlet weak var interestedInWomen: UISwitch!
    
    @IBAction func SignUp(sender: AnyObject) {
        
        PFUser.currentUser()?["interestedInWomen"] = interestedInWomen.on
        PFUser.currentUser()?.saveInBackground()
        
        
        
    }
    override func viewDidLoad() {
        
       
        
        super.viewDidLoad()
        
        
     /*
        let urlArray = ["http://top10for.com/wp-content/uploads/2014/02/Angelina-Jolie1.jpg" , "http://im.rediff.com/movies/2014/jan/07best-telugu-actors3.jpg" , "http://cdn.pcwallart.com/images/famous-actresses-wallpaper-3.jpg" , "http://hdwidescreenwallpapers.com/wp-content/uploads/2013/11/south-indian-actress-wallpaper-hd.jpg" , "http://p1.pichost.me/i/42/1656537.jpg", "http://www.andhrawishesh.com/images/stories/AWEnglish/April-2013/Mahesh.jpg" , "http://pics.cinetara.com/sites/2/2014/06/25/54022/Telugu-Actor-Allu-Arjun-Photo-Shoot-Stills-021.jpg" , "https://4.bp.blogspot.com/-JWwJz6e4l0k/UkKraFM9AYI/AAAAAAAANYk/81cJs7xq8fU/s0/keira+knightley.jpg" , "http://www.toptenfamous.com/wp-content/uploads/2012/08/Emma-Watson.jpg" , "http://top10for.com/wp-content/uploads/2014/02/Scarlett-Johansson.jpg", "http://cdn0.dailydot.com/cache/96/92/9692f1da96f846ab0517df8fcbf41042.jpg","http://ia.media-imdb.com/images/M/MV5BMjEyNzAyMzcyOF5BMl5BanBnXkFtZTgwNTg3OTAzMTE@._V1._SX412_CR0,0,412,412_.jpg","http://images.moneymanager.com.au/2014/10/31/5939760/Article%20Lead%20-%20wide6282832911evh6image.related.articleLeadwide.729x410.11emnd.png1414741134356.jpg-620x349.jpg"]
        var counter = 1
        
        for url in urlArray {
        
            if  let nsurl = NSURL(string: url) {
            
            
                if let data = NSData(contentsOfURL: nsurl) {
                    
                    self.UserImage.image = UIImage(data: data)
                    
                    let imageFile : PFFile = PFFile(data: data)
                    
                    var user :PFUser = PFUser()
                    
                    var username = "user\(counter)"
                    
                    user["image"] = imageFile
                    
                    user.username = username
                    user.password = "pass"
                    
                    user["interestedInWomen"] = false
                    user["gender"] = "female"
                   
                    counter++
                    user.signUp()
                    
                    
                }

        
            }
        }
        
        */
        
        
        
        
        
        
        
        
        
        
        
        let graphRequest  = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" :"id , name , gender "])
        graphRequest.startWithCompletionHandler { (connection, result, error) -> Void in
            
            if error != nil {
            
            print(error)
            
            } else if let result = result {
            
            PFUser.currentUser()?["gender"] = result["gender"]
                PFUser.currentUser()?["name"] = result["name"]
                
                
                
                PFUser.currentUser()?.saveInBackground()
                var userId = result["id"] as? String
                
                print(userId)
                
                var facebookProfilePicUrl = "http://graph.facebok.com/" + userId! + "/picture?type=large"
                
                
                
                
                if let fbPicUrl = NSURL(string: facebookProfilePicUrl) {
                    
                    
                    if let data = NSData(contentsOfURL: fbPicUrl) {
                        
                        self.UserImage.image = UIImage(data: data)
                        
                        let imageFile : PFFile = PFFile(data: data)
                        
                        PFUser.currentUser()?["image"] = imageFile
                        
                        PFUser.currentUser()?.saveInBackground()
                        
                        
                        
                    }
                }
                
                
                    }
                
                }
                
                
                
            
        
            
           
            
        }

        // Do any additional setup after loading the view.


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
   

}
