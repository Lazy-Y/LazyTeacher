//
//  MyTV.swift
//  L02
//
//  Created by 钟镇阳 on 5/31/15.
//  Copyright (c) 2015 钟镇阳. All rights reserved.
//

import UIKit

class CalTBV: UITableView, UITableViewDelegate, UITableViewDataSource{
    
    var page:Int!
    var parent:CalTB!
    
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
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        cell.textLabel?.text = cellText(indexPath.row, "")
        if schedule[page][indexPath.row] {
            cell.textLabel?.textColor = UIColor.greenColor()
        }
        else {
            cell.textLabel?.textColor = UIColor.grayColor()
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        var cell = cellForRowAtIndexPath(indexPath)
        if schedule[page][indexPath.row]{
            schedule[page][indexPath.row] = false
            cell?.textLabel?.textColor = UIColor.redColor()
        }
        else {
            schedule[page][indexPath.row] = true
            cell?.textLabel?.textColor = UIColor.greenColor()
        }
        reloadData()
    }
}
