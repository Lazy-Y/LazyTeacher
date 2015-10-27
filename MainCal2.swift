//
//  MainCal.swift
//  bridge
//
//  Created by 钟镇阳 on 6/11/15.
//  Copyright (c) 2015 钟镇阳. All rights reserved.
//

import UIKit

class MainCal2: UIViewController, UIPageViewControllerDataSource {
    var Date = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    func indexAt(index:Int)->UIViewController?{
        var page = self.storyboard?.instantiateViewControllerWithIdentifier("Match") as! Match
        page.text = Date[index]
        page.pageIndex = index
        return page
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?{
        var viewController = viewController as! Match
        var index = viewController.pageIndex as Int
        if (index==0 || index == NSNotFound){
            return nil
        }
        index--
        while index > -1 && currNode.cal_[index] is Int{
            index--
        }
        if index < 0 || index == NSNotFound{
            return nil
        }
        //println("left")
        return indexAt(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?{
        var viewController = viewController as! Match
        var index = viewController.pageIndex as Int
        if index == 6 || index == NSNotFound{
            return nil
        }
        index++
        while index < 7 && currNode.cal_[index] is Int{
            index++
        }
        if index > 6 || index == NSNotFound{
            return nil
        }
        //println("right")
        return indexAt(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int{
        return numOfDays
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int{
        return 0
    }
    
    var pageViewController:UIPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("page") as! UIPageViewController
        self.pageViewController.dataSource = self
        var initIndex = 0
        for i in 0..<7{
            if !(currNode.cal_[i] is Int){
                initIndex = i
                break
            }
        }
        var initial = self.indexAt(initIndex) as! Match
        var viewControllers = NSArray(object: initial)
        self.pageViewController.setViewControllers(viewControllers as [AnyObject], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        self.pageViewController.view.frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.height-100)
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
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
