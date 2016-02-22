//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Clark Kent on 2/20/16.
//  Copyright © 2016 Antonio Singh. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var tweets:[Tweet]!
    var isMoreDataLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "TWITTER"
        
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.tintColor = UIColor(red: 0.0, green: 1.25, blue: 3.25, alpha: 0.8)
            
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.grayColor().colorWithAlphaComponent(0.5)
            shadow.shadowOffset = CGSizeMake(2, 2);
            shadow.shadowBlurRadius = 4;
            navigationBar.titleTextAttributes = [
                NSFontAttributeName : UIFont.boldSystemFontOfSize(22),
                NSForegroundColorAttributeName : UIColor(red: 0.5, green: 0.20, blue: 0.25, alpha: 0.8),
                NSShadowAttributeName : shadow
            ]
        }
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        TwitterClient.sharedInstance.homeTimeline({ ( tweets:[Tweet]) -> () in
            
            self.tweets = tweets
            
            if (tweets == tweets) {
                
                self.tableView.reloadData()
            }
            
            for tweet in tweets {
                print (tweet.textbox)
            }
            
            }, failure: { (error: NSError) -> () in
                print (error.localizedDescription)
        })
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tweets != nil {
            
            return tweets!.count
            
        } else {
            
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        
        return cell
        
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
     
        let request = NSURLRequest(
            URL: NSURL(string: "https://api.twitter.com")!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (data, response, error) in
                
                // Reload the tableView now that there is new data
                self.tableView.reloadData()
                
                // Tell the refreshControl to stop spinning
                refreshControl.endRefreshing()
        });
        task.resume()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if (!isMoreDataLoading) {
            isMoreDataLoading = true
            
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.dragging) {
                isMoreDataLoading = true
                
                loadMoreData()
                
            }
            
        }
        
    }
    
    func loadMoreData() {
        
        let request = NSURLRequest(
            URL: NSURL(string: "https://api.twitter.com")!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (data, response, error) in
                
                self.isMoreDataLoading = false
                
                // Reload the tableView now that there is new data
                self.tableView.reloadData()
                
        });
        task.resume()
        
    }
    

    
    @IBAction func onLogoutButton(sender: AnyObject) {
        
        TwitterClient.sharedInstance.logout()
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
