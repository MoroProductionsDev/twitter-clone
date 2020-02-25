//
//  LoginViewController.swift
//  Twitter
//
//  Created by RAUL RIVERO RUBIO on 2/23/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    let TWITTER_URL = "https://api.twitter.com/oauth/request_token"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginEvent(_ sender: Any) {
        TwitterAPICaller.client?.login(url: TWITTER_URL,
           success: {
            self.performSegue(withIdentifier: "login_homepage", sender: self)
        },
           failure: { (Error) in
            print("Could not logged in")
        })
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
