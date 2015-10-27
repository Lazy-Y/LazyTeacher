//
//  MyTV.swift
//  L02
//
//  Created by 钟镇阳 on 5/31/15.
//  Copyright (c) 2015 钟镇阳. All rights reserved.
//

import UIKit

class CourseTBV: UITableView, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    
    var loadFinish = true
    var isRefreshing = true
    var currIndex = 0
    var parent:SmartSearch!
    var dic=Array<Array<NSDictionary>>()
    var listState = true
    var firstDic=Array<NSDictionary>()
    var BOV:BreakOutToRefreshView!
    
    func prev(){
        if currIndex == 0{
            return
        }
        currIndex--
        reloadData()
    }
    
    func next(){
        if currIndex+1 == dic.count{
            return
        }
        currIndex++
        reloadData()
    }
    
    func reloadDic(row:Int){
        parent.wait.startAnimating()
        if row == -1{
            dic.append(firstDic)
            currIndex++
            return
        }
        
        var url = NSURL(string: mainURL+"classname.list")
        var request = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10.0)
        request.HTTPMethod = "POST"
        var upload = "id=" + (String(dic[currIndex][row]["id"] as! Int) as String)
        request.HTTPBody = upload.dataUsingEncoding(NSUTF8StringEncoding)
        isRefreshing = true
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (resp, data, err) -> Void in
            self.isRefreshing = false
            if err != nil {
                UIAlertView(title: "Error", message: err?.localizedDescription, delegate: nil, cancelButtonTitle: "OK").show()
                return
            }
            var arr = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)) as! Array<NSMutableDictionary>
            if arr.isEmpty{
                self.loadFinish = true
                //self.reloadData()
                return
            }
            //println(arr)
            self.currIndex++
            for i in self.currIndex..<self.dic.count{
                self.dic.removeAtIndex(i)
            }
            var newArr = Array<NSDictionary>()
            for item in arr{
                var newDic = ["id":(item["id"] as! Int),"name":(NSString(CString: (item["name"] as! String),encoding: NSUTF8StringEncoding) as! String)] as NSDictionary
                newArr.append(newDic)
            }
            self.dic.append(newArr)
            self.loadFinish = true
            //self.reloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.dataSource=self
        self.delegate=self
        
    }
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.dataSource=self
        self.delegate=self
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if dic.count == 0{
            return 0
        }
        if dic[currIndex].isEmpty {
            reload()
        }
        return dic[currIndex].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell = UITableViewCell()
        cell.textLabel!.text = (dic[currIndex][indexPath.row]["name"] as! String)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        loadFinish = false
        reloadDic(indexPath.row)
        reload()
    }
    func reload() {
        while !loadFinish{
            NSRunLoop.currentRunLoop().runMode(NSDefaultRunLoopMode, beforeDate:NSDate.distantFuture() as! NSDate)
        }
        reloadData()
        parent.wait.stopAnimating()
    }
}

extension CourseTBV{
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        BOV.isDragging = true
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        BOV.isDragging = false
        BOV.isRefreshing = self.isRefreshing
        if !BOV.isRefreshing && scrollView.contentOffset.y + scrollView.contentInset.top < -BOV.sceneHeight {
            BOV.beginRefreshing()
            targetContentOffset.memory.y = -BOV.scrollView.contentInset.top
            BOV.delegate?.refreshViewDidRefresh(BOV)
        }
        
        if !BOV.isRefreshing {
            BOV.endRefreshing()
        }
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let frameHeight = frame.size.height
        let yPosition = BOV.sceneHeight - (-scrollView.contentInset.top-scrollView.contentOffset.y)*2
        
        BOV.breakOutScene.moveHandle(yPosition)
    }
}