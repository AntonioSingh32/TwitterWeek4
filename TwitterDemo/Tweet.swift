//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Clark Kent on 2/20/16.
//  Copyright © 2016 Antonio Singh. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var user:User?
    
    var textbox: NSString?
    var timestamp: NSDate?
    var retweetCount: Int=0
    var favoritesCount: Int=0
    var userid: NSNumber?
    var profuser: NSString?

    
    init(dictionary: NSDictionary) {
        
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        
        textbox = dictionary ["text"] as? String
        retweetCount = (dictionary ["retweet_count"] as! Int) ?? 0
        favoritesCount = (dictionary ["favourites_count"] as? Int) ?? 0
        
        userid = dictionary ["id"] as! Int
        profuser = dictionary["name"] as? String
        
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString {
            
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        timestamp = formatter.dateFromString(timestampString)
        
        }
        
        
    }
 
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
    
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet (dictionary: dictionary)
            
            tweets.append(tweet)
            
        }
    
        return tweets
        
    }
    
    func addRetweet() {
        
        retweetCount=retweetCount+1
        
    }
    
    func addFavorite() {
        
        favoritesCount=favoritesCount+1
    }
    
    func removeRetweet() {
        
        retweetCount=retweetCount-1
    }
    
    func removeFavorite() {
        
        favoritesCount = favoritesCount-1
    }
    
    class func tweetAsDictionary(dict: NSDictionary) -> Tweet {
        
        // print(dict)
        
        let tweet = Tweet(dictionary: dict)
        
        return tweet
    }

}
