//
//  signup.swift
//  bridge
//
//  Created by 钟镇阳 on 6/1/15.
//  Copyright (c) 2015 钟镇阳. All rights reserved.
//

import UIKit

class signup: UIViewController {
    @IBOutlet var Name: UITextField!

    @IBOutlet var Email: UITextField!
    
    @IBOutlet var Birth: UITextField!
    
    @IBOutlet var Pass: UITextField!
    
    @IBAction func signup(sender: AnyObject) {
        let name : String = Name.text
        if (name.characters.count<5 || name.characters.count>20){
            UIAlertView(title: "Warning", message: "User name's length should be between 5~20", delegate: nil, cancelButtonTitle: "OK").show()
            return
        }
        if !isValidEmail(Email.text){
            UIAlertView(title: "Warning", message: "Email address is not valid", delegate: nil, cancelButtonTitle: "OK").show()
            return
        }
        var year_ : Int
        if let year = Int(Birth.text){
            if (year<1900 || year>2015){
                UIAlertView(title: "Warning", message: "Your birth year is not valid, a valid birth year should be between 1900~2015", delegate: nil, cancelButtonTitle: "OK").show()
                return
            }
            year_ = year
        }
        else {
            UIAlertView(title: "Warning", message: "Birth should be integer, your birth year", delegate: nil, cancelButtonTitle: "OK").show()
            return
        }
        if (Pass.text.characters.count<4 || Pass.text.characters.count>8){
            UIAlertView(title: "Warning", message: "A valid password should contain 4~8 characters", delegate: nil, cancelButtonTitle: "OK").show()
            return
        }
        //var url = NSURL(string: "http://localhost:63342/htdocs/sqlite/signup.php")
        var url = NSURL(string: mainURL+"user.register")

        var request = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10.0)
        request.HTTPMethod = "POST"
        var up = "name=" + Name.text + "&password=" + String(hash_fun(Pass.text)) + "&email=" + Email.text + "&birth=" + Birth.text
        request.HTTPBody = up.dataUsingEncoding(NSUTF8StringEncoding)
        var received:NSDictionary!
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (resp, data1, e) -> Void in
            if e != nil {
                UIAlertView(title: "Error", message: "there is error", delegate: nil, cancelButtonTitle: "OK").show()
                return
            }
            if e != nil{
                UIAlertView(title: "Error", message: e.localizedDescription, delegate: nil, cancelButtonTitle: "OK").show()
            }
            
            received = (try? NSJSONSerialization.JSONObjectWithData(data1!, options: NSJSONReadingOptions.MutableContainers)) as? NSDictionary
            //println(received)
            if received["status"] as! Int == 0{
                //println("run exist")
                UIAlertView(title: "Sorry", message: "This username has already existed, please try another one", delegate: nil, cancelButtonTitle: "OK").show()
            }
            else {
                print(received, terminator: "")
            }
        }
    }
    
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
