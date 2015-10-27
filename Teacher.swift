//
//  Teacher.swift
//  bridge
//
//  Created by 钟镇阳 on 6/14/15.
//  Copyright (c) 2015 钟镇阳. All rights reserved.
//

import UIKit

class Teacher: UIViewController {
    
    @IBOutlet var table: TeacherList!    
    
    @IBAction func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.controller = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goTo(){
        var vc = teacherInfo(nibName:"teacherInfo",bundle:nil)
        
        var url = NSURL(string: mainURL+"teacherInfo.php")
        
        var request = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10.0)
        request.HTTPMethod = "POST"
        var upload = "classID=" + "&teacher=" +
            currNode.instructor_
        request.HTTPBody = upload.dataUsingEncoding(NSUTF8StringEncoding)
        var received:NSString!
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (resp, data, e) -> Void in
            if e != nil {
                UIAlertView(title: "Error", message: "there is error", delegate: nil, cancelButtonTitle: "OK").show()
                return
            }
            received = NSString(data: data!, encoding: NSUTF8StringEncoding)!
        
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
        vc.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(vc, animated: true, completion: nil)
    }
}
