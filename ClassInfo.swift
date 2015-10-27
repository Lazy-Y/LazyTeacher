//
//  ClassInfo.swift
//  bridge
//
//  Created by 钟镇阳 on 6/13/15.
//  Copyright (c) 2015 钟镇阳. All rights reserved.
//

import UIKit

class ClassInfo: UIViewController {
    var tvc:CalTB!
    
    @IBOutlet var scroll: UIScrollView!
    
    @IBOutlet var fullName: UILabel!
    @IBOutlet var instructor: UIButton!
    @IBOutlet var ID: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var size: UILabel!
    @IBOutlet var discription: UITextView!
    @IBOutlet var time: UITextView!
    var id:String!
    var info:NSDictionary!
    @IBAction func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in})
    }
    
    @IBOutlet var register: UIButton!
    
    @IBOutlet var change: UIButton!
    
    @IBAction func regi(sender: AnyObject) {
    }
    
    @IBAction func chpl(sender: AnyObject) {
    }
    
    func alertView(View: UIAlertView, clickedButtonAtIndex buttonIndex: Int){
        /*
        switch buttonIndex{
            
        case 0:
            return
        case 1:
            var p = View.textFieldAtIndex(0)?.text
            if (thisUser["ZPASSWORD"] as! String).toInt() == hash_fun(p!){
                var url = NSURL(string: (mainURL + "viewInfo.php"))
                var request = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10.0)
                request.HTTPMethod = "POST"
                
                var upload = "classID=" + ID.text! + "&currName=" + (thisUser["ZNAME"] as! String)
                request.HTTPBody = upload.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
                var resp:NSURLResponse?
                var err:NSError?
                var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &resp, error: &err)
                if err != nil {
                    UIAlertView(title: "Error", message: err?.description, delegate: nil, cancelButtonTitle: "OK")
                    return
                }
                var receive = NSString(data: data!, encoding: NSUTF8StringEncoding)
                //println(receive)
                if receive == "error"{
                    UIAlertView(title: "Sorry", message: "Unable to drop this course. Please try again", delegate: nil, cancelButtonTitle: "OK")
                    return
                }
                for each in classes{
                    if each["ZCLASSID"] as? String == ID.text{
                        (each as NSMutableDictionary)["ZSTATE"] = "dropped"
                        break
                    }
                }
                for i in 0..<7{
                    for j in 0..<28{
                        if schedule[i][j] == ID.text{
                            //println("set")
                            schedule[i][j] = "f"
                        }
                    }
                }
                tvc.table.reloadData()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            else {
                UIAlertView(title: "Sorry", message: "Incorrect password", delegate: nil, cancelButtonTitle: "OK")
                return
            }
            return
        default:
            return
        }
*/
    }
    
    @IBAction func drop(sender: AnyObject) {
        let alert = UIAlertView(title: "Dorp Class", message: "Are you sure to drop this class?", delegate: nil, cancelButtonTitle: "Cancel", otherButtonTitles: "OK")
        alert.delegate = self
        
        alert.alertViewStyle = UIAlertViewStyle.SecureTextInput
        
        alert.show()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //println(info)
        fullName.text = (info["ZCLASSCODE"] as? String)!
        instructor.setTitle(info["ZTEACHER"] as? String, forState: UIControlState.Normal)
        location.text = info["ZLOCATION"] as? String
        size.text = classSize(Int((info["ZSIZE"] as! String))!)
        discription.text = info["ZDESCRIPT"] as? String
        ID.text = id
        time.text = classTime(info["ZTIME"] as! NSArray)
        time.editable = false
        discription.editable = false
        
        scroll.scrollEnabled = true
        scroll.contentSize = CGSize(width: 320, height: 800)
        // Do any additional setup after loading the view.
    }

    @IBAction func viewInfo(sender: AnyObject) {
        var vc = teacherInfo(nibName:"teacherInfo",bundle:nil)
        vc.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        vc.parent = self
        var url = NSURL(string: mainURL + "teacherInfo.php")
        var request = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10.0)
        request.HTTPMethod = "POST"
        var upload = "teacher=" + (info["ZTEACHER"] as! String) + "&classID=" + (info["ZCLASSCODE"] as! String)
        request.HTTPBody = upload.dataUsingEncoding(NSUTF8StringEncoding)
        var received:NSString!
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (resp, data, e) -> Void in
            if e != nil {
                UIAlertView(title: "Error", message: e.description, delegate: nil, cancelButtonTitle: "OK").show()
            }
            received = NSString(data: data, encoding: NSUTF8StringEncoding)
            //println(received)
            if let thisInfo = (try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)) as? NSDictionary{
                vc.info = thisInfo

                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    vc.setInfo()
                    
                })
            }
            else {
                UIAlertView(title: "Sorry", message: "Data are unavailable", delegate: nil, cancelButtonTitle: "OK")
                return
            }
            
        }
        vc.title = "Wait for loading..."
        self.presentViewController(vc, animated: true, completion: nil)
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
