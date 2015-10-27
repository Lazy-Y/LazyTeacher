//
//  DatePick.swift
//  LazyTeacher
//
//  Created by 钟镇阳 on 7/15/15.
//  Copyright (c) 2015 钟镇阳. All rights reserved.
//

import UIKit

class DatePick: UIViewController {
    
    var parent:MainCal!
    var start:Bool!

    @IBOutlet var pick: UIDatePicker!
    
    @IBAction func set(sender: AnyObject) {
        if (start == true){
            parent.start_date = pick.date
        }
        else {
            parent.end_date = pick.date
        }
        parent.setTime()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pick.datePickerMode = UIDatePickerMode.Date
        pick.minimumDate = NSDate()
        if start == true {
            pick.date = parent.start_date
        }
        else {
            pick.date = parent.end_date
            pick.minimumDate = parent.start_date
        }
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
