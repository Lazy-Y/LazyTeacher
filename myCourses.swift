//
//  myCourses.swift
//  LazyTeacher
//
//  Created by 钟镇阳 on 7/13/15.
//  Copyright (c) 2015 钟镇阳. All rights reserved.
//

import UIKit

class myCourses: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        myCoursesInfo = [["高三\n物理","高三数学","高三化学"],["高二物理","高二数学","高二化学"],["高一物理","高一数学","高一化学"]]
        /*
        var url = NSURL(string: mainURL+"myCourses.php")
        
        var request = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10.0)
        request.HTTPMethod = "POST"
        var upload = "currUser=" + (thisUser["ZNAME"] as! String)
        
        request.HTTPBody = upload.dataUsingEncoding(NSUTF8StringEncoding)
        
        var resp:NSURLResponse?
        var err:NSError?
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &resp, error: &err)
        myCoursesInfo = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as! Array<Array<String>>*/
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
