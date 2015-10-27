//
//  TPSeting.swift
//  LazyTeacher
//
//  Created by 钟镇阳 on 7/5/15.
//  Copyright (c) 2015 钟镇阳. All rights reserved.
//

import UIKit

class TPSeting: UIViewController {

    @IBOutlet var picker: UIDatePicker!
    @IBOutlet var slider: UISlider!
    @IBOutlet var hours: UILabel!
    
    @IBAction func goBack(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func slide(sender: AnyObject) {
        hours.text = String(stringInterpolationSegment: Int(slider.value))+" h"
    }
    
    @IBAction func back(sender: AnyObject) {
        tbv.prev()
    }
    var tbv:Loc!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.datePickerMode = UIDatePickerMode.Date
        // Do any additional setup after loading the view.
        slider.continuous = false
        slider.minimumValue = 20
        slider.maximumValue = 100
        slider.setValue(20, animated: false)
        tbv = Loc(frame: CGRect(x: 0, y: 300, width: 320, height: 200),style: UITableViewStyle.Plain)
        self.view.insertSubview(tbv, atIndex: 0)
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
