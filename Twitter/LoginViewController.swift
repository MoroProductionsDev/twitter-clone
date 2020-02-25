//
//  LoginViewController.swift
//  Twitter
//
//  Created by RAUL RIVERO RUBIO on 2/23/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var errorLabel: UILabel!
    let TWITTER_URL = "https://api.twitter.com/oauth/request_token"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.displayError(flag: false)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (UserDefaults.standard.bool(forKey: "authentication") == true) {
            // redirect to the homepage
            self.performSegue(withIdentifier: "login_homepage", sender: self)
        }
    }

    @IBAction func loginEvent(_ sender: Any) {
        TwitterAPICaller.client?.login(url: TWITTER_URL,
           success: {
            // Saved the state, so the user stays logged in
            UserDefaults.standard.set(true, forKey: "authentication")
            
            // redirect to the homepage
            self.performSegue(withIdentifier: "login_homepage", sender: self)
        },
           failure: { (Error) in
            self.errorLabel.text = "Could not logged in"
            self.displayError(flag: true)
            // print("Could not logged in")
        })
    }
    
    func displayError(flag: Bool) {
        if (flag) {
            self.errorLabel.alpha = 1.0
        }
        else {
            self.errorLabel.alpha = 0.0
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
