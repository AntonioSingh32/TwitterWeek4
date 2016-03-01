//
//  ProfileCell.swift
//  TwitterDemo
//
//  Created by Clark Kent on 3/1/16.
//  Copyright © 2016 Antonio Singh. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var usprofImage: UIImageView!
    
    @IBOutlet weak var usprofnameLabel: UILabel!
    
    @IBOutlet weak var usprofhandleLabel: UILabel!
    
    @IBOutlet weak var usproftweetLabel: UILabel!
    
    var tweet: Tweet!{
        
        didSet{
            
            usprofnameLabel.text = tweet.user?.name as? String
            usprofhandleLabel.text = "@\((tweet.user?.screenname)!)"
            usproftweetLabel.text = tweet.textbox as? String
            
            usprofImage.setImageWithURL((tweet.user?.profileURL)!)
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
