//
//  UserProfileViewController.swift
//  TwitterDemo
//
//  Created by Clark Kent on 3/1/16.
//  Copyright © 2016 Antonio Singh. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var otherprofImage: UIImageView!
    
    @IBOutlet weak var otherprofnameLabel: UILabel!
    
    @IBOutlet weak var otherprofhandleLabel: UILabel!
    
    @IBOutlet weak var othertweetscountLabel: UILabel!
    
    @IBOutlet weak var otherfollowingcountLabel: UILabel!
    
    @IBOutlet weak var otherfollowerscountLabel: UILabel!
    
    @IBOutlet weak var othercoverImage: UIImageView!
    
    var tweet: Tweet?
    var backgroundImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        otherprofnameLabel.text = tweet?.user?.name as? String
        otherprofhandleLabel.text = "@\((tweet?.user?.screenname)!)"
        otherprofImage.setImageWithURL(((tweet?.user?.profileURL)!))
        
        let data = NSData(contentsOfURL: (tweet?.user?.profileBannerURL)!)
        backgroundImage = UIImage(data: data!)
        
        
        othercoverImage.image = backgroundImage
        
        othertweetscountLabel.text = "\((tweet?.user?.userfollowersCount)!)"
        otherfollowerscountLabel.text = "\((tweet?.user?.userfollowersCount)!)"
        otherfollowingcountLabel.text = "\((tweet?.user?.userfollowingCount)!)"
        
        
        // Do any additional setup after loading the view.
    }

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
