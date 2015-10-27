//
//  teacherInfo.swift
//  LazyTeacher
//
//  Created by 钟镇阳 on 6/25/15.
//  Copyright (c) 2015 钟镇阳. All rights reserved.
//

import UIKit

class teacherInfo: UIViewController {
    
    @IBOutlet var noImage: UILabel!
    
    var info:NSDictionary!
    
    @IBOutlet var name: UILabel!
    @IBAction func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet var OK: UIButton!
    @IBAction func next(sender: AnyObject) {
        var oneStoryBoard:UIStoryboard = UIStoryboard(name: "Matching", bundle: NSBundle.mainBundle())
        let vc = oneStoryBoard.instantiateViewControllerWithIdentifier("first") as! UIViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        vc.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    @IBOutlet var image: UIImageView!

    @IBOutlet var Organization: UIButton!
    
    @IBOutlet var Location: UILabel!
    @IBOutlet var Rating: UILabel!
    
    @IBOutlet var history: UILabel!
    @IBOutlet var Students: UILabel!
    @IBOutlet var VIP: UILabel!
    @IBOutlet var Elite: UILabel!
    @IBOutlet var Small: UILabel!
    @IBOutlet var Middle: UILabel!
    @IBOutlet var Large: UILabel!
    @IBAction func Calview(sender: AnyObject) {
    }

    @IBOutlet var EXP: UITextView!
    @IBOutlet var SD: UITextView!
    @IBOutlet var VA: UITextView!
    @IBOutlet var UVA: UITextView!
    @IBOutlet var SC: UITextView!
    
    @IBOutlet var scroll: UIScrollView!
    
    @IBAction func viewOrgan(sender: AnyObject) {
    }
    
    func changeImage(){
        image.image = UIImage(named: String(arc4random()%13)+".jpg")
    }
    
    var parent:UIViewController!
    
    
    func setInfo(){
        if image.image == nil{
            changeImage()
            image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "changeImage"))
        }
        var str:String = (info["ZNAME"] as! String)
        name.text = str
        Organization.setTitle((info["ZORGAN"] as! String), forState: UIControlState.Normal)
        str = (info["ZLOC"] as! String)
        Location.text = str
        str = (info["ZQUAN"] as! String)
        Students.text = str
        history.text = (info["ZCLQU"] as! String)
        var a = Float(Int((info["ZQUAL"] as! String))!)
        var b = Float(Int((info["ZQUAN"] as! String))!)
        var rate:NSString!
        if b == 0 {
            rate = "N/A"
        }
        else {
            rate = NSString(format: "%.02f", a/b)
        }
        Rating.text = rate as String
        VIP.text = "$"+(info["ZVIP"] as! String)+"/h"
        Elite.text = "$"+(info["ZELITE"] as! String)+"/h"
        Small.text = "$"+(info["ZSMALL"] as! String)+"/h"
        Middle.text = "$"+(info["ZMIDDLE"] as! String)+"/h"
        Large.text = "$"+(info["ZLARGE"] as! String)+"/h"
        EXP.text = "No experience available."
        if (info["ZEXP"] is NSNull || (info["ZEXP"] as! String).characters.isEmpty) {
            EXP.text = "No experience available."
        }
        else {
            var arr = (info["ZEXP"] as! String).componentsSeparatedByString(",") as Array<String>
            var text = ""
            var first = true
            for item in arr{
                if first {
                    first = false
                }
                else {
                    text += "\n"
                }
                
                //text +=
                //var a:NSDateFormatter
            }
        }
        if info["ZDESCRI"] is NSNull || (info["ZEXP"] as! String).characters.isEmpty {
            SD.text = "He is a lazy teacher, just left the self-description empty"
        }
        else {
            SD.text = info["ZDESCRI"] as! String
        }
        if info["ZVERIFIED"] is NSNull || (info["ZEXP"] as! String).characters.isEmpty {
            VA.text = "No thing is available"
        }
        else{
            VA.text = info["ZVERIFIED"] as! String
        }
        if info["ZUNVERIFIED"] is NSNull || (info["ZEXP"] as! String).characters.isEmpty {
            UVA.text = "No thing is available"
        }
        else {
            UVA.text = info["ZUNVERIFIED"] as! String
        }
        if info["ZREV"] is NSNull || (info["ZEXP"] as! String).characters.isEmpty {
            SC.text = "No thing is available"
        }
        else {
            SC.text = info["ZREV"] as! String
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scroll.scrollEnabled = true
        scroll.contentSize = CGSize(width: 320, height: 1700)
        EXP.editable = false
        SD.editable = false
        VA.editable = false
        UVA.editable = false
        SC.editable = false
        image.userInteractionEnabled = true;
        if parent is ClassInfo{
            OK.hidden = true
        }
        noImage.hidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
