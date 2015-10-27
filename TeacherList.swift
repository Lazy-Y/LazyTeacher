//
//  MyTV.swift
//  L02
//
//  Created by 钟镇阳 on 5/31/15.
//  Copyright (c) 2015 钟镇阳. All rights reserved.
//

import UIKit

class TeacherList: UITableView, UITableViewDelegate, UITableViewDataSource{
    
    var controller:Teacher!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.dataSource=self
        self.delegate=self
    }
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return tempArr.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        cell.textLabel?.text = "\((tempArr[indexPath.row] as! Node).instructor_)\t\tSimilarity \((tempArr[indexPath.row] as! Node).rate_)"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        currNode = (tempArr[indexPath.row] as! Node)
        controller.goTo()
        numOfDays = 0
        for i in 0..<7{
            if !(currNode.cal_[i] is Int){
                numOfDays++
            }
        }
        cellForRowAtIndexPath(indexPath)?.selected = false
    }
}
