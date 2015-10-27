//
//  MainTabBar.swift
//  LazyTeacher
//
//  Created by 钟镇阳 on 7/20/15.
//  Copyright (c) 2015 钟镇阳. All rights reserved.
//

import UIKit

class MainTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var oneStoryBoard:UIStoryboard = UIStoryboard(name: "Main1", bundle: NSBundle.mainBundle())
        let vc = oneStoryBoard.instantiateViewControllerWithIdentifier("first") as! UINavigationController
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Contacts, tag: 1)
        addChildViewController(vc)
        
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
