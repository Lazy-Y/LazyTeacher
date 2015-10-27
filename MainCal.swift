//
//  MainCal.swift
//  bridge
//
//  Created by 钟镇阳 on 6/11/15.
//  Copyright (c) 2015 钟镇阳. All rights reserved.
//

import UIKit

class MainCal: UIViewController, UIPageViewControllerDataSource,UIPopoverPresentationControllerDelegate,UISearchBarDelegate {
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .None
    }
    
    var start_date = NSDate()
    var end_date = NSDate()
    var parent:WorkingHour!

    @IBAction func startDate(sender: UIButton) {
        var popVC = DatePick(nibName: "DatePick", bundle: nil)
        popVC.modalPresentationStyle = .Popover
        popVC.preferredContentSize = CGSize(width: 320, height: 160)
        let pop = popVC.popoverPresentationController
        pop?.delegate = self
        pop?.permittedArrowDirections = .Up
        pop?.sourceView = sender as UIView
        popVC.parent = self
        popVC.start = true
        self.navigationController?.presentViewController(popVC, animated: true, completion: nil)
    }
    
    @IBAction func endDate(sender: UIButton) {
        var popVC = DatePick(nibName: "DatePick", bundle: nil)
        popVC.modalPresentationStyle = .Popover
        popVC.preferredContentSize = CGSize(width: 320, height: 160)
        let pop = popVC.popoverPresentationController
        pop?.delegate = self
        pop?.permittedArrowDirections = .Up
        pop?.sourceView = sender as UIView
        popVC.parent = self
        popVC.start = false
        self.navigationController?.presentViewController(popVC, animated: true, completion: nil)
    }
    @IBOutlet var begin: UIButton!
    
    @IBOutlet var end: UIButton!
    
    @IBAction func done(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
        //self.dismissViewControllerAnimated(true, completion: { () -> Void in
            /*//var url = NSURL(string: "http://localhost:63342/htdocs/sqlite/viewInfo.php")
            var url = NSURL(string: mainURL+"viewInfo.php")

            var request = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10.0)
            request.HTTPMethod = "POST"
            var upload:String = "currName=" + (thisUser["ZNAME"] as! String)
            for i in 0..<7{
                upload += "&" + toIndex(i) + "=" + arrToStr(schedule[i])
            }
            request.HTTPBody = upload.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler: { (resp, data, err) -> Void in
                if err != nil {
                    UIAlertView(title: "Error", message: err.localizedDescription, delegate: nil, cancelButtonTitle: "OK").show()
                    return
                }
                if data != nil{
                    var msg = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    //println(msg)
                }
            })*/
        //})
    }
    
    
    var Date = ["星期天","星期一","星期二","星期三","星期四","星期五","星期六"]
    //var Date = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    func indexAt(index:Int)->UIViewController?{
        var page = self.storyboard?.instantiateViewControllerWithIdentifier("CalTB") as! CalTB
        page.text = Date[index]
        page.pageIndex = index
        return page
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?{
        var viewController = viewController as! CalTB
        var index = viewController.pageIndex as Int
        if (index==0 || index == NSNotFound){
            return nil
        }
        index--
        return indexAt(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?{
        var viewController = viewController as! CalTB
        var index = viewController.pageIndex as Int
        if index == 6 || index == NSNotFound{
            return nil
        }
        index++
        return indexAt(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int{
        return Date.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int{
        return 0
    }
    
    var pageViewController:UIPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("page") as! UIPageViewController
        self.pageViewController.dataSource = self
        var initial = self.indexAt(0) as! CalTB
        var viewControllers = NSArray(object: initial)
        self.pageViewController.setViewControllers(viewControllers as [AnyObject], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        self.pageViewController.view.frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.height-100)
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        // Do any additional setup after loading the view.
        setTime()
        var arr = Array<Bool>(count: 28, repeatedValue: false)
        if schedule == nil {
            schedule = Array<Array<Bool>>(count: 7, repeatedValue: arr)
        }
    }
    
    func setTime(){
        if start_date.earlierDate(end_date) == end_date{
            end_date = start_date
        }
        begin.setTitle(dateForm.stringFromDate(start_date), forState: UIControlState.Normal)
        end.setTitle(dateForm.stringFromDate(end_date), forState: UIControlState.Normal)
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
