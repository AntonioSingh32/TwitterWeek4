//
//  ProfileViewController.swift
//  TwitterDemo
//
//  Created by Clark Kent on 2/25/16.
//  Copyright © 2016 Antonio Singh. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var proftableView: UITableView!
    
    @IBOutlet weak var userprofImage: UIImageView!
    @IBOutlet weak var userprofnameLabel: UILabel!
    @IBOutlet weak var userprofhandleLabel: UILabel!
    @IBOutlet weak var usercoverImage: UIImageView!
    @IBOutlet weak var tweetcountLabel: UILabel!
    
    @IBOutlet weak var followingcountLabel: UILabel!
    
    @IBOutlet weak var followerscountLabel: UILabel!
    
    
    var user:User?
    var tweet:Tweet!
    var tweets:[Tweet]!
    var backgroundImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        proftableView.delegate = self
        proftableView.dataSource = self
        
        userprofnameLabel.text = User.currentUser?.name as? String
        userprofhandleLabel.text = "@\((User.currentUser?.screenname)!)"
        userprofImage.setImageWithURL((User.currentUser?.profileURL)!)
        
        let data = NSData(contentsOfURL: (User.currentUser?.profileBannerURL)!)
        backgroundImage = UIImage(data: data!)
        
        usercoverImage.image = backgroundImage
        
        tweetcountLabel.text = "\((User.currentUser?.usertweetCount)!)"
        followingcountLabel.text = "\((User.currentUser?.userfollowingCount)!)"
        followerscountLabel.text = "\((User.currentUser?.userfollowersCount)!)"
        

        }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tweets != nil {
            
            return tweets!.count
            
        } else {
            
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ProfileCell", forIndexPath: indexPath) as! ProfileCell
        
        cell.tweet = tweets[indexPath.row]
        
        return cell
        
        
        
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
