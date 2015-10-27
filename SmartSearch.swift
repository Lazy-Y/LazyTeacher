//
//  SmartSearch.swift
//  LazyTeacher
//
//  Created by 钟镇阳 on 6/29/15.
//  Copyright (c) 2015 钟镇阳. All rights reserved.
//

import UIKit
import Foundation

class SmartSearch: UIViewController,UIPopoverPresentationControllerDelegate,UISearchBarDelegate {
    
    @IBOutlet var wait: UIActivityIndicatorView!
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .None
    }
    
    @IBAction func 高级(sender: UIButton) {
        var oneStoryBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let popVC = oneStoryBoard.instantiateViewControllerWithIdentifier("pop") as! Course3
        popVC.modalPresentationStyle = .Popover
        popVC.preferredContentSize = CGSize(width: 300, height: 300)
        let pop = popVC.popoverPresentationController
        pop?.delegate = self
        pop?.permittedArrowDirections = .Up
        pop?.sourceView = sender as UIView
        self.navigationController?.presentViewController(popVC, animated: true, completion: nil)
    }

    @IBAction func 综合(sender: AnyObject) {
        allBlue()
        a.tintColor = UIColor.redColor()
    }
    
    @IBAction func 评分(sender: AnyObject) {
        allBlue()
        b.tintColor = UIColor.redColor()
    }
    
    @IBAction func 价格(sender: AnyObject) {
        allBlue()
        c.tintColor = UIColor.redColor()
    }
    
    @IBAction func 距离(sender: AnyObject) {
        allBlue()
        d.tintColor = UIColor.redColor()
    }
 
    @IBAction func 经验(sender: AnyObject) {
        allBlue()
        e.tintColor = UIColor.redColor()
    }
    
    @IBOutlet var a: UIButton!
    @IBOutlet var b: UIButton!
    @IBOutlet var c: UIButton!
    @IBOutlet var d: UIButton!
    @IBOutlet var e: UIButton!
    func allBlue(){
        a.tintColor = UIColor.blueColor()
        b.tintColor = UIColor.blueColor()
        c.tintColor = UIColor.blueColor()
        d.tintColor = UIColor.blueColor()
        e.tintColor = UIColor.blueColor()
    }
    
    @IBOutlet var SearchBar: UISearchBar!
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        //tbv.reloadDic(searchText)
    }
    
    func startSearch(){
        var text = SearchBar.text
        //println(text)
        /*
        if text == nil {
            tbv.reloadDic("no")
        }
        else {
            tbv.reloadDic(text)
        }
        tbv.reloadData()*/
    }
    
    func initDic(){
        tbv.loadFinish = false
        var url = NSURL(string: mainURL+"classname.list")
        var request = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10.0)
        request.HTTPMethod = "POST"
        var upload = ""
        request.HTTPBody = upload.dataUsingEncoding(NSUTF8StringEncoding)
        tbv.isRefreshing = true
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (resp, data, err) -> Void in
            self.tbv.isRefreshing = false
            if err != nil {
                UIAlertView(title: "Error", message: err?.localizedDescription, delegate: nil, cancelButtonTitle: "OK").show()
                return
            }
            var arr = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)) as! Array<NSMutableDictionary>
            print(arr)
            for i in self.tbv.currIndex..<self.tbv.dic.count{
                self.tbv.dic.removeAtIndex(i)
            }
            var newArr = Array<NSDictionary>()
            for item in arr{
                var newDic = ["id":(item["id"] as! Int),"name":(NSString(CString: (item["name"] as! String),encoding: NSUTF8StringEncoding) as! String)] as NSDictionary
                newArr.append(newDic)
            }
            self.tbv.firstDic = newArr
            self.tbv.dic.append(self.tbv.firstDic)
            self.tbv.loadFinish = true
            //self.tbv.reload()
        }
        self.tbv.reload()
    }

    var refreshView:BreakOutToRefreshView!

    @IBOutlet var tbv: CourseTBV!
    override func viewDidLoad() {
        super.viewDidLoad()
        allBlue()
        SearchBar.placeholder = "老师，课程，地名"
        tbv.parent = self
        a.tintColor = UIColor.redColor()
        SearchBar.delegate = self
        initDic()
        //wait.startAnimating()
        
        let refreshHeight = CGFloat(100)
        if refreshView == nil {
            refreshView = BreakOutToRefreshView(scrollView: tbv)
        }
        tbv.addSubview(refreshView)
        tbv.delegate = tbv
        tbv.BOV = refreshView
        
        var swipeLeft = UISwipeGestureRecognizer(target: tbv, action: "next")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        var swipeRight = UISwipeGestureRecognizer(target: tbv, action: "prev")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        tbv.addGestureRecognizer(swipeLeft)
        tbv.addGestureRecognizer(swipeRight)
        
        wait.hidesWhenStopped = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension SmartSearch: BreakOutToRefreshDelegate {
    
    func refreshViewDidRefresh(refreshView: BreakOutToRefreshView) {
        // this code is to simulage the loading from the internet
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC * 3)), dispatch_get_main_queue(), { () -> Void in
            refreshView.endRefreshing()
        })
    }
    
}