 //
//  TweetCell.swift
//  Twitter
//
//  Created by RAUL RIVERO RUBIO on 2/25/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    var hasFavorited : Bool = false
    var tweetId : Int = -999
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func toggleFavoritedState(_ isFavorited : Bool) {
        self.hasFavorited = !hasFavorited
        if (self.hasFavorited) {
            favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        } else {
            favoriteButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func toggleRetweetState(_ isRetweeted : Bool) {
        if (isRetweeted) {
            self.retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            self.retweetButton.isEnabled = false
        } else {
            self.retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            self.retweetButton.isEnabled = true
        }
    }

    @IBAction func favoriteTweetEvent(_ sender: Any) {
        let toBeFavorited = !hasFavorited
        if (toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId,
           success: {self.toggleFavoritedState(true)},
           failure: {(error) in
            print("Favorite API call did not succeed: \(error)")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId,
           success: {self.toggleFavoritedState(false)},
           failure: {(error) in
            print("Unfavorite API call did not succeed: \(error)")
            })
        }
    }
    
    @IBAction func retweetEvent(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId,
            success: {self.toggleRetweetState(true)},
            failure: {(error) in
                print("Retweet API call did not succeed: \(error)")
        })
    }
 }
