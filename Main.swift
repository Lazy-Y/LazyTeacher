//
//  Main.swift
//  bridge
//
//  Created by 钟镇阳 on 6/3/15.
//  Copyright (c) 2015 钟镇阳. All rights reserved.
//

import UIKit

class Main: UIViewController{
    
    @IBOutlet var wait: UIActivityIndicatorView!
    var searchViewController:SmartSearch!
    @IBAction func searchClass(sender: AnyObject) {
        wait.startAnimating()
        dispatch_async(dispatch_get_global_queue(0, 0), { () -> Void in
            var oneStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            if self.searchViewController == nil {
                self.searchViewController = oneStoryBoard.instantiateViewControllerWithIdentifier("searchClass") as! SmartSearch
                print(self.searchViewController)
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.wait.stopAnimating()
                self.navigationController?.pushViewController(self.searchViewController, animated: true)
            })
        })
    }
    
    
    
    @IBAction func newCal(sender: AnyObject) {
        var oneStoryBoard:UIStoryboard = UIStoryboard(name: "CVCal", bundle: NSBundle.mainBundle())
        let vc = oneStoryBoard.instantiateViewControllerWithIdentifier("first") as! CVCal
        vc.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBOutlet var noImage: UILabel!
    
    @IBOutlet var welcome: UINavigationItem!

    
    @IBOutlet var image: UIImageView!
    
    func info() {
        var oneStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc = oneStoryBoard.instantiateViewControllerWithIdentifier("viewInfo") as! viewInfo
        var url = NSURL(string: mainURL+"user.info")
        var request = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10.0)
        request.HTTPMethod = "POST"
        var upload = "id=" + String(userID)
        request.HTTPBody = upload.dataUsingEncoding(NSUTF8StringEncoding)
        var received:NSDictionary!
        var resp:NSURLResponse?
        var synError:NSError?
        var data: NSData?
        do {
            data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &resp)
        } catch var error as NSError {
            synError = error
            data = nil
        }
        if synError != nil {
            UIAlertView(title: "Error", message: synError!.localizedDescription, delegate: nil, cancelButtonTitle: "OK").show()
            return
        }
        received = (try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)) as? NSDictionary
        print(received)
        vc.b = received["birth"] as! String
        vc.e = received["email"] as! String
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func out(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func viewNews(sender: AnyObject) {
        var oneStoryBoard:UIStoryboard = UIStoryboard(name: "CVCal", bundle: NSBundle.mainBundle())
        let vc = oneStoryBoard.instantiateViewControllerWithIdentifier("news") as! newsView
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func setInfo(name:String, path:String){
        welcome.title = currUser
        if let imageLoad = UIImage(contentsOfFile: thisUser["ZIMAGE"] as! String){
            image.image = imageLoad
            noImage.hidden = true
        }
        else{
            image.image = UIImage(named: String(arc4random()%13)+".jpg")
            noImage.hidden = false
        }
    }
    
    func changeImage(){
        image.image = UIImage(named: String(arc4random()%13)+".jpg")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        wait.hidesWhenStopped = true
        main = self
        noImage.hidden = true
        image.userInteractionEnabled = true;
        noImage.hidden = true
        if image.image == nil {
            changeImage()
            image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "changeImage"))
            var swipeLeft = UISwipeGestureRecognizer(target: self, action: "changeImage")
            swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
            image.addGestureRecognizer(swipeLeft)
            var swipeRight = UISwipeGestureRecognizer(target: self, action: "changeImage")
            swipeRight.direction = UISwipeGestureRecognizerDirection.Right
            image.addGestureRecognizer(swipeRight)
            self.noImage.hidden = false
        }
        //self.navigationController?.navigationBar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "info"))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
