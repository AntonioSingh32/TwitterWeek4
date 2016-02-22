//
//  TweetCell.swift
//  TwitterDemo
//
//  Created by Clark Kent on 2/21/16.
//  Copyright © 2016 Antonio Singh. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var retweetLabel: UILabel!
    
    @IBOutlet weak var favoriteLabel: UILabel!
    
    @IBAction func retweetButton(sender: AnyObject) {
        
        tweet.addRetweet()
    }
    
    @IBAction func favoriteButton(sender: AnyObject) {
        
        tweet.addFavorite()
    }
    @IBAction func unretweetButton(sender: AnyObject) {
        
        tweet.removeRetweet()
    }
    
    @IBAction func unfavoriteButton(sender: AnyObject) {
        
        tweet.removeFavorite()
    }
    var tweet: Tweet! {
        didSet {
            
        nameLabel.text = tweet.user!.name as? String
        handleLabel.text = "@\(tweet.user!.screenname!)" as? String
        messageLabel.text = tweet.textbox as? String
        profileImage.setImageWithURL(tweet.user!.profileURL!)
        retweetLabel.text = "\(tweet.retweetCount)" as? String
        favoriteLabel.text = "\(tweet.favoritesCount)" as? String
        
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImage.layer.cornerRadius = 2
        // Initialization code
    }
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
