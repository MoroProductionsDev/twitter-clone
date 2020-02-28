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
    var favorited : Bool = false
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
        self.favorited = isFavorited
        if (self.favorited) {
            favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        } else {
            favoriteButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }

    @IBAction func favoriteTweetEvent(_ sender: Any) {
        favorited = !favorited
        if(favorited) {
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
        
    }
 }
