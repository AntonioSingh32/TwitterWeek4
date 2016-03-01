//
//  ExpandedViewController.swift
//  TwitterDemo
//
//  Created by Clark Kent on 2/23/16.
//  Copyright © 2016 Antonio Singh. All rights reserved.
//

import UIKit

class ExpandedViewController: UIViewController {

    @IBOutlet weak var exprofImage: UIImageView!
    
    @IBOutlet weak var exnameLabel: UILabel!
    
    @IBOutlet weak var exhandleLabel: UILabel!
    
    @IBOutlet weak var extweetLabel: UILabel!
    
    @IBOutlet weak var exdateLabel: UILabel!
    
    @IBOutlet weak var exretweetLabel: UILabel!
    
    @IBOutlet weak var exfavoriteLabel: UILabel!
    
    @IBOutlet weak var exretweetcountLabel: UILabel!
    
    @IBOutlet weak var exfavoritecountLabel: UILabel!
    
    @IBAction func RTButton(sender: AnyObject) {
        
    }
    @IBAction func FVButton(sender: AnyObject) {
    }
    @IBAction func RPButton(sender: AnyObject) {
    }
    var user:User?
    var tweet:Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
                exnameLabel.text = tweet.user!.name as? String
                exhandleLabel.text = "@\(tweet.user!.screenname!)"
                extweetLabel.text = tweet.textbox as? String
                exprofImage.setImageWithURL(tweet.user!.profileURL!)
                exretweetcountLabel.text = "\(tweet.retweetCount)"
                exfavoritecountLabel.text = "\(tweet.favoritesCount)"
                exdateLabel.text = "\(tweet.timestamp)" 
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        /*let detailViewController = segue.destinationViewController as! UserProfileViewController
        detailViewController.tweet = tweet*/

        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
