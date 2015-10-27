//
//  Loc.swift
//  LazyTeacher
//
//  Created by 钟镇阳 on 7/6/15.
//  Copyright (c) 2015 钟镇阳. All rights reserved.
//

import UIKit

class Loc: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var level = Array<String>()
    
    func prev(){
        arr = Array<String>()
        level.removeLast()
        if level.count == 0{
            for i in 0..<loc.count{
                arr.append((loc as NSDictionary).allKeys[i] as! String)
            }
        }
        reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //data = NSDictionary(contentsOfFile: "data.plist")!
        self.dataSource=self
        self.delegate=self
    }
    override init(frame: CGRect, style: UITableViewStyle){
        super.init(frame: frame, style: style)
        arr = Array<String>()
        for i in 0..<loc.count{
            arr.append((loc as NSDictionary).allKeys[i] as! String)
        }
        self.dataSource=self
        self.delegate=self
    }
    
    var arr:Array<String>!

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return arr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell()
        cell.textLabel?.text = arr[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if level.count == 1 {
            return
        }
        level.append((cellForRowAtIndexPath(indexPath)!.textLabel?.text as String?)!)
        arr = loc[level[level.count-1]]
        reloadData()
    }

}
