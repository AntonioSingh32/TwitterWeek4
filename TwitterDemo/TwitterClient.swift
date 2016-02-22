//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by Clark Kent on 2/20/16.
//  Copyright © 2016 Antonio Singh. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {

    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "bgRg2Pex4gqJ7oBgvDBMqx9f0", consumerSecret: "Lss3sSbwp4dJBJbgVYiiRjNQbiJxBddt0alkldzRCi9pN8XRDR")
    
    var loginSuccess: (() -> ())?
    var loginFailure: (((NSError)) -> ())?
 
    func login(success: () -> (), failure: (NSError) -> ()) {
        
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.deauthorize()
        
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "mytwitterdemo://oauth"), scope: nil, success: { (requestToken:BDBOAuth1Credential!) -> Void in
            print("I got a token!")
            
            let url = NSURL (string:"https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(url!)
            
            }) { (error:NSError!) -> Void in
                print("error:\(error.localizedDescription)")
                self.loginFailure?(error)
        }
    }
    
    func homeTimeline(success: ([Tweet]) -> (), failure: NSError -> ()) {
        
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task:NSURLSessionDataTask, response:AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
            success(tweets)
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure (error)
                
        })
    }
    
    func logout() {
        
        User.currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.UserDidLogoutNotification, object: nil)
        
    }
    
    
    func handleOpenUrl (url:NSURL) {
        
         let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        TwitterClient.sharedInstance.fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: {
            
            (accessToken: BDBOAuth1Credential!) -> Void in
            print ("I got the access token!")
            
            self.currentAccount({ (user: User) -> () in
                
                 User.currentUser = user
                 self.loginSuccess?()
                
                }, failure: { (error: NSError) -> () in
                    self.loginFailure?(error)
            })
           
            
            }) { (error: NSError!) -> Void in
                print("error:\(error.localizedDescription)")
            self.loginFailure?(error)
        }
        
    }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()) {
        
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task:NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
            print("name:\(user.name)")
            
            print("screenname:\(user.screenname)")
            
            print("profile url:\(user.profileURL)")
            
            print("description:\(user.tagline)")
            
            },failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                
            failure(error)
                
        })
    }
    
    
    

}
