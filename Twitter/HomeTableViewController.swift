//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by RAUL RIVERO RUBIO on 2/24/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    let refControl = UIRefreshControl()
    let RESOURCE_URL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
    let CELLCOUNT : Int = 20
    
    var tweets = [NSDictionary]()
    var tweetscount : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTweets()
        
        // Pull Request
        refControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = refControl
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func loadTweets() {
        tweetscount = CELLCOUNT
        let PARAMS = ["count" : tweetscount]
        // Call API client and getting the dictionaries
        TwitterAPICaller.client?.getDictionariesRequest(
            url: RESOURCE_URL,
            parameters: PARAMS,
            success: {
                (tweets: [NSDictionary]) in
                // empty the entire dictonary array
                self.tweets.removeAll()
                
                // Loop through all the api dictionaries
                for tweet in tweets {
                    self.tweets.append(tweet)
                }
                
                // reloads tableView data
                self.tableView.reloadData()
                // End the refreshing cycle
                self.refControl.endRefreshing()
        }, failure: {(Error) in
            print("ERROR: Could not retrieve tweets")
        })
    }
    
    func loadMoreTweets() {
        tweetscount = tweetscount * 2
        
        let PARAMS = ["count" : tweetscount]
        // Call API client and getting the dictionaries
        TwitterAPICaller.client?.getDictionariesRequest(
            url: RESOURCE_URL,
            parameters: PARAMS,
            success: {
                (tweets: [NSDictionary]) in
                // empty the entire dictonary array
                self.tweets.removeAll()
                
                // Loop through all the api dictionaries
                for tweet in tweets {
                    self.tweets.append(tweet)
                }
                
                // reloads tableView data
                self.tableView.reloadData()
        }, failure: {(Error) in
            print("ERROR: Could not retrieve tweets")
        })
    }
    
    // Action to take when it reach the end of the tableView
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // if indexPath.row is more thant the dictionary array count
        // load more tweets
        if indexPath.row + 1 == self.tweets.count {
            loadMoreTweets()
        }
    }

    @IBAction func logoutEvent(_ sender: Any) {
        // logout from the API
        TwitterAPICaller.client?.logout()
        
        // Saved the state, so the user stays logged out
        UserDefaults.standard.set(false, forKey: "authentication")
        
        // Go back to login page
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        let user = tweets[indexPath.row]["user"] as! NSDictionary
        let imageURL = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageURL!)
        
        cell.userNameLabel.text = user["name"] as? String
        cell.tweetContentLabel.text = tweets[indexPath.row]["text"] as? String
        
        if let imageData = data {
            cell.avatarImageView.image = UIImage(data: imageData)
        }
        
        return cell
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.tweets.count
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
