//
//  ViewController.swift
//  weeks
//
//  Created by Will on 9/4/15.
//  Copyright (c) 2015 Will Field-Thompson. All rights reserved.
//

import UIKit

class ServiceLoginViewController: UIViewController {
    
    @IBOutlet var loginButton: FBSDKLoginButton!
    @IBOutlet var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loginButton.readPermissions = ["public_profile"]
        
        let engine = InstagramEngine.sharedEngine()
        UIApplication.sharedApplication().openURL(engine.authorizarionURL())
    }
    
    @IBAction func fetchFB(sender: AnyObject) {
        let engine = InstagramEngine.sharedEngine()
        engine.getSelfRecentMediaWithSuccess(
            { media, pageInfo in
                self.textView.text = "\(media)"
            },
            failure: { error, status in
                println(error)
            }
        )
        /*
        println("fetching")
        let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"posts"])
        req.startWithCompletionHandler {
            conn, result, error in
            self.textView.text = "\(result)"
        }*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

