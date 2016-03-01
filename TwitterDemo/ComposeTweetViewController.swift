//
//  ComposeTweetViewController.swift
//  TwitterDemo
//
//  Created by Clark Kent on 2/28/16.
//  Copyright © 2016 Antonio Singh. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController {
    
    
    @IBOutlet weak var compprofImage: UIImageView!

    @IBOutlet weak var compprofnameLabel: UILabel!
    
    @IBOutlet weak var compprofhandleLabel: UILabel!
    
    @IBOutlet weak var compproftweetText: UITextView!
    
    @IBAction func comptweetButton(sender: AnyObject) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        compprofnameLabel.text = User.currentUser?.name as? String
        compprofhandleLabel.text = "@\((User.currentUser?.screenname)!)"
        compprofImage.setImageWithURL((User.currentUser?.profileURL)!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
