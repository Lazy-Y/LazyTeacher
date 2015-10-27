//
//  MatchTBV.swift
//  bridge
//
//  Created by 钟镇阳 on 6/14/15.
//  Copyright (c) 2015 钟镇阳. All rights reserved.
//

import UIKit

class MatchTBV: UITableView, UITableViewDelegate, UITableViewDataSource {
    var index:Int!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.dataSource=self
        self.delegate=self
    }
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 28
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        ///Users/ZhenyangZhong/cs/bridge/bridge/MatchTBV.swift:35:12: Binary operator '==' cannot be applied to operands of type 'UITableViewCell' and 'nil'
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        var str = (currNode.cal_[index] as! NSArray)[indexPath.row] as! String
        if str == "f"{
            cell.textLabel!.text = cellText(indexPath.row, "Free")
            cell.textLabel?.textColor = UIColor.greenColor()
        }
        else if str == "o"{
            cell.textLabel!.text = cellText(indexPath.row, "Occupied")
            cell.textLabel?.textColor = UIColor.redColor()
        }
        else {
            str = " "
            var row = indexPath.row
            var text:String = cellText(row, str)
            cell.textLabel!.text = text
            cell.textLabel?.textColor = UIColor.blueColor()
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        var count_:Int = date[index] as! Int
        if indexPath.row + count_ >= 28{
            return
        }
        for i in 0 ..< count_{
            var text:AnyObject = (currNode.cal_[index] as! NSArray)[i+indexPath.row]
            if text as! String == "o"{
                cellForRowAtIndexPath(indexPath)?.selected = false
                return
            }
        }
        //println(indexPath.row)
        for i in 0 ..< 28{
            var text:AnyObject = (currNode.cal_[index] as! NSArray)[i]
            var cell = cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0))
            if cell != nil {
                if cell!.textLabel!.textColor == UIColor.blueColor(){
                    cell!.textLabel!.text = cellText(indexPath.row, "Free")
                    cell!.textLabel?.textColor = UIColor.greenColor()
                }
            }
            if text as! String == "t"{
                (currNode.cal_[index] as! NSMutableArray)[i] = "f"
            }
        
        }
        for i in 0 ..< count_ {
            (currNode.cal_[index] as! NSMutableArray)[i+indexPath.row] = "t"
            var cell = cellForRowAtIndexPath(NSIndexPath(forRow: i+indexPath.row, inSection: 0))
            if cell != nil{
                var str = " "
                var row = indexPath.row
                var text = cellText(row+i, str)
                cell!.textLabel!.text = text
                cell?.textLabel?.textColor = UIColor.blueColor()
            }
        }
        cellForRowAtIndexPath(indexPath)?.selected = false
    }
}
