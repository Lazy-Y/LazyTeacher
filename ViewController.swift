//
//  ViewController.swift
//  bridge
//
//  Created by 钟镇阳 on 6/1/15.
//  Copyright (c) 2015 钟镇阳. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet var pass: UITextField!
    @IBOutlet var name: UITextField!
    
    @IBOutlet var wait: UIActivityIndicatorView!
    var activityIndicatorView:UIActivityIndicatorView!
    
    @IBAction func login(sender: AnyObject) {
        
        var oneStoryBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = oneStoryBoard.instantiateViewControllerWithIdentifier("mainPage") as! UITabBarController
        vc.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(vc, animated: true, completion: nil)
        /*
        wait.startAnimating()
        dispatch_async(dispatch_get_global_queue(0, 0), { () -> Void in
            var url = NSURL(string: mainURL+"user.login")
            var request = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10.0)
            request.HTTPMethod = "POST"
            var up = "name=" + self.name.text + "&password=" + String(hash_fun(self.pass.text))
            request.HTTPBody = up.dataUsingEncoding(NSUTF8StringEncoding)
            println(up)
            var received:NSDictionary!
            var resp:NSURLResponse?
            var synError:NSError?
            var data1 = NSURLConnection.sendSynchronousRequest(request, returningResponse: &resp, error: &synError)
            if synError != nil {
                UIAlertView(title: "Error", message: synError!.localizedDescription, delegate: nil, cancelButtonTitle: "OK").show()
                self.wait.stopAnimating()
                return
            }
            received = NSJSONSerialization.JSONObjectWithData(data1!, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary
            println(received)
            if received == nil {
                UIAlertView(title: "错误", message: "网络加载有问题哟", delegate: nil, cancelButtonTitle: "OK").show()
                self.wait.stopAnimating()
                return
            }
            if received["status"] as! Int == 0 {
                UIAlertView(title: "Fail", message: "Login Fail, incorrect user name or password", delegate: nil, cancelButtonTitle: "OK").show()
                self.wait.stopAnimating()
                return
            }
            else {
                userID = received["user_id"] as! Int
                var oneStoryBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                let vc = oneStoryBoard.instantiateViewControllerWithIdentifier("mainPage") as! UITabBarController
                vc.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
                currUser = received["user_name"] as! String
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.wait.stopAnimating()
                    self.presentViewController(vc, animated: true, completion: { () -> Void in
                        main.welcome.title = currUser
                        if let loadImage = UIImage(contentsOfFile: "a.jpg"){
                            main.image.image = loadImage
                        }
                    })
                })
            }
        })*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = "Lazy-Y"
        pass.text = "123456"
        wait.hidesWhenStopped = true
        dateForm.dateStyle = NSDateFormatterStyle.MediumStyle
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

