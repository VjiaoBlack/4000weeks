//
//  ViewController.swift
//  weeks
//
//  Created by Will on 9/4/15.
//  Copyright (c) 2015 Will Field-Thompson. All rights reserved.
//
/*

import UIKit

class ServiceLoginViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet var imageView: UIImageView!
    
    var igurls: [NSURL] = []
    
    var webview: UIWebView = UIWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //loginButton.readPermissions = ["public_profile"]
        
        let engine = InstagramEngine.sharedEngine()
        let scope = InstagramKitLoginScope.Basic
        webview.delegate = self
        webview.loadRequest(NSURLRequest(URL: engine.authorizarionURLForScope(scope)))
        webview.frame = view.bounds
        view.addSubview(webview)
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        var err: NSError?
        if (InstagramEngine.sharedEngine().receivedValidAccessTokenFromURL(request.URL, error: &err)) {
            webview.removeFromSuperview()
            fetchIG(nil)
            return false
        }
        return true
    }
    
    @IBAction func fetchIG(sender: AnyObject?) {
        let engine = InstagramEngine.sharedEngine()
        engine.getPopularMediaWithSuccess(
            { media, pageInfo in
                let igmedia = media.filter { $0 is InstagramMedia } as! [InstagramMedia]
                let f: (InstagramMedia) -> NSURL = {
                    if $0.isVideo {
                        return $0.standardResolutionVideoURL
                    } else {
                        return $0.standardResolutionImageURL
                    }
                }
                self.igurls = igmedia.map(f)
                let url = self.igurls[0]
                let req = NSURLRequest(URL: url)
                var resp: NSURLResponse?
                var e: NSError?
                if let data = NSURLConnection.sendSynchronousRequest(req, returningResponse: &resp, error: &e),
                image = UIImage(data: data) {
                    self.imageView.image = image
                }
            },
            failure: { error, status in
                println(error)
            }
        )
        /*
        println("fetching FB")
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

*/