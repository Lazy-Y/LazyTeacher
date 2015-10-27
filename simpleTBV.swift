//
//  MyTV.swift
//  L02
//
//  Created by 钟镇阳 on 5/31/15.
//  Copyright (c) 2015 钟镇阳. All rights reserved.
//

import UIKit

class simpleTBV: UITableView, UITableViewDelegate, UITableViewDataSource{

    
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
        return 28
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell = UITableViewCell()
        cell.textLabel?.text = cellText(indexPath.row, "")
        cell.textLabel?.textColor = UIColor.grayColor()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        var cell = cellForRowAtIndexPath(indexPath)
        cell?.textLabel?.textColor = (cell?.textLabel?.textColor == UIColor.greenColor()) ? UIColor.grayColor() : UIColor.greenColor()
    }
  }
