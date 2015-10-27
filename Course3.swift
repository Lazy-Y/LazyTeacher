//
//  Course3.swift
//  bridge
//
//  Created by 钟镇阳 on 6/6/15.
//  Copyright (c) 2015 钟镇阳. All rights reserved.
//

import UIKit

class Course3: UIViewController {
    @IBOutlet var SunS: UISlider!
    @IBOutlet var SunL: UILabel!
    @IBOutlet var MonS: UISlider!
    @IBOutlet var MonL: UILabel!
    @IBOutlet var TuesS: UISlider!
    @IBOutlet var TuesL: UILabel!
    @IBOutlet var WedS: UISlider!
    @IBOutlet var WedL: UILabel!
    @IBOutlet var ThursS: UISlider!
    @IBOutlet var ThursL: UILabel!
    @IBOutlet var FriS: UISlider!
    @IBOutlet var FriL: UILabel!
    @IBOutlet var SatS: UISlider!
    @IBOutlet var SatL: UILabel!
    @IBAction func SunA(sender: AnyObject) {
        SunL.text = String(hour(SunS.value)) + " h"
    }
    @IBAction func MonA(sender: AnyObject) {
        MonL.text = String(hour(MonS.value)) + " h"
    }
    @IBAction func TuesA(sender: AnyObject) {
        TuesL.text = String(hour(TuesS.value)) + " h"
    }
    @IBAction func WedA(sender: AnyObject) {
        WedL.text = String(hour(WedS.value)) + " h"
    }
    @IBAction func ThursA(sender: AnyObject) {
        ThursL.text = String(hour(ThursS.value)) + " h"
    }
    @IBAction func FriA(sender: AnyObject) {
        FriL.text = String(hour(FriS.value)) + " h"
    }
    @IBAction func SatA(sender: AnyObject) {
        SatL.text = String(hour(SatS.value)) + " h"
    }
    
    var courseID:AnyObject!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SunS.continuous = false
        MonS.continuous = false
        TuesS.continuous = false
        WedS.continuous = false
        ThursS.continuous = false
        FriS.continuous = false
        SatS.continuous = false
        SunS.minimumValue = 0
        MonS.minimumValue = 0
        TuesS.minimumValue = 0
        WedS.minimumValue = 0
        ThursS.minimumValue = 0
        FriS.minimumValue = 0
        SatS.minimumValue = 0
        SunS.maximumValue = 10
        MonS.maximumValue = 10
        TuesS.maximumValue = 10
        WedS.maximumValue = 10
        ThursS.maximumValue = 10
        FriS.maximumValue = 10
        SatS.maximumValue = 10
        SunS.setValue(0, animated: false)
        MonS.setValue(0, animated: false)
        TuesS.setValue(0, animated: false)
        WedS.setValue(0, animated: false)
        ThursS.setValue(0, animated: false)
        FriS.setValue(0, animated: false)
        SatS.setValue(0, animated: false)
        SunL.text = "0.0 h"
        MonL.text = "0.0 h"
        TuesL.text = "0.0 h"
        WedL.text = "0.0 h"
        ThursL.text = "0.0 h"
        FriL.text = "0.0 h"
        SatL.text = "0.0 h"
//        courseID = data_MyTV2[words[1]]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
