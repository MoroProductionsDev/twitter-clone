//
//  TweetViewController.swift
//  Twitter
//
//  Created by RAUL RIVERO RUBIO on 2/27/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    @IBOutlet weak var tweetTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelEvent(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweetEvent(_ sender: Any) {
        // check if it is not empty
        if (!tweetTextView.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text,
            success: {
                self.dismiss(animated: true, completion: nil)   // dismiss the page
                
            },
            failure: {(Error) in
                print("Error posting tweet \(Error)")           // print the error
                self.dismiss(animated: true, completion: nil)   // dismiss the page
            })
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
