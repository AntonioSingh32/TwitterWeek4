//
//  User.swift
//  TwitterDemo
//
//  Created by Clark Kent on 2/20/16.
//  Copyright © 2016 Antonio Singh. All rights reserved.
//

import UIKit

class User: NSObject {

    var name: NSString?
    var screenname: NSString?
    var profileURL: NSURL?
    var tagline: NSString?
    var profileBannerString: NSString?
    var profileBannerURL: NSURL?
    var usertweetCount: Int?
    var userfollowersCount: Int?
    var userfollowingCount: Int?
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary ["screen_name"] as? String
        tagline = dictionary["description"] as? String
        
        usertweetCount = dictionary["statuses_count"] as? Int
        userfollowingCount = dictionary["friends_count"] as? Int
        userfollowersCount = dictionary["followers_count"] as? Int
        
         profileBannerString = dictionary["profile_background_image_url_https"] as? String
        
        
        let profileURLstring = dictionary ["profile_image_url_https"] as? String
        
        if profileBannerString != nil {
            profileBannerURL = NSURL(string: profileBannerString! as String)!
        }
        else {
            profileBannerURL = nil

        }
        
        if let profileURLstring = profileURLstring {
            
            profileURL = NSURL(string: profileURLstring)
        }
        
        }
    
    static let UserDidLogoutNotification = "UserDidLogout"
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        
        get {
            if _currentUser == nil {
            
            let defaults = NSUserDefaults.standardUserDefaults()
        
            let userData = defaults.objectForKey("currentUserData") as? NSData
        
            if let userData = userData {
        
                let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
                
                _currentUser = User(dictionary: dictionary)
               
                }

            }
            
            return _currentUser
        }
        
        set(user) {
            
            _currentUser = user
            
            let defaults = NSUserDefaults.standardUserDefaults()
            
            if let user = user {
                let data = try!NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                defaults.setObject(data, forKey: "currentUserData")
            } else {
                defaults.setObject(nil, forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }

        }

    }

    
    

