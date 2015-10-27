//
//  globle.swift
//  bridge
//
//  Created by 钟镇阳 on 6/14/15.
//  Copyright (c) 2015 钟镇阳. All rights reserved.
//
import Foundation

func pow(x:Int,y:Int)->Int{
    var b = 1
    for i in 0..<y{
        b*=x
    }
    return b
}

func hash_fun(n:String)->Int{
    var k = n.characters.count
    var a = 0
    for b in 0..<k {
        var c = pow(128,k-b-1)
        a+=c
    }
    //var m = [0,0,0,0]
    var m = [Int]()
    for i in 0..<4{
        var q = a%65521
        m.append(q)
        a/=65521
    }
    var w = 45912 * m[0]
    w += 35511 * m[1]
    w += 65169 * m[2]
    w += 4625 * m[3]
    w %= 65521;
    return w
}

func hour(t:Float)->Float{
    var time:Int = lroundf(t)
    var str = String(time/2)
    if time%2 == 0 {
        return (str as NSString).floatValue
    }
    return (str as NSString).floatValue+0.5
}

func classSize(n:Int)->String{
    if n==1{
        return "VIP: 1 person"
    }
    else if n==2{
        return "Elite: 2~5 people"
    }
    else if n==3{
        return "Small: 6~12 people"
    }
    else if n==4{
        return "Middle: 13~20 people"
    }
    return "Large: >20 people"
}

func convert(i:AnyObject)->Int{
    return Int((i as! String))!
}

func classTime(t:NSArray)->String{
    var str = ""
    var size:Int = t.count/3
    //println(t)
    //println(t[0])
    for i in 0 ..< size {
        str += week(convert(t[i]))
        str += "\t\t\t"
        str += transTime(convert(t[i+1]))
        str += "~"
        str += transTime(convert(t[i+1]) + convert(t[i+2]))
        str += "\n"
    }
    return str
}

func transTime(n:Int)->String{
    if n%2 == 0{
        return "\(8+n/2):00"
    }
    return "\(8+n/2):30"
}

func week(d:Int)->String{
    if d == 0{
        return "Sun."
    }
    if d == 1{
        return "Mon."
    }
    if d == 2{
        return "Tues."
    }
    if d == 3{
        return "Wed."
    }
    if d == 4{
        return "Thurs."
    }
    if d == 5{
        return "Fri."
    }
    return "Sat."
}

func isValidEmail(testStr:String) -> Bool {
    // println("validate calendar: \(testStr)")
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluateWithObject(testStr)
}

func cellText(row:Int,str:String)->String{
    if row%2 == 0 {
        return "\(row/2+8):00 ~ \(row/2+8):30\t\t\(str)"
    }
    else {
        return "\(row/2+8):30 ~ \(row/2+9):00\t\t\(str)"
    }
}

func toIndex(i:Int)->String{
    return "ZD" + String(i)
}

func arrToStr(arr:NSArray)->String{
    var str = ""
    var first = true
    for i in arr{
        if first{
            first = false
        }
        else {
            str += ","
        }
        str += (String(i) as String)
    }
    return str
}

func scheduleToArr(start:NSDate,end:NSDate)->Array<String>{
    var arr = Array<String>()
    arr.append(dateForm.stringFromDate(start))
    arr.append(dateForm.stringFromDate(end))
    for item in schedule{
        arr.append(dayToString(item))
    }
    print(arr)
    return arr
}

func dayToString(day:Array<Bool>)->String{
    var str = ""
    var first = true
    for i in 0..<day.count{
        if day[i]{
            if first{
                first = false
                str = String(i)
            }
            else {
                str += "/" + String(i)
            }
        }
    }
    return str
}

func arrToSchedule(arr:Array<String>)->(NSDate,NSDate){
    schedule.removeAll(keepCapacity: false)
    for i in 2..<9{
        schedule.append(stringToDay(arr[i]))
    }
    return (dateForm.dateFromString(arr[0])!,dateForm.dateFromString(arr[1])!)
}

func stringToDay(str:String)->Array<Bool>{
    var arr = Array<Bool>(count: 28, repeatedValue: false)
    if str.isEmpty{
        return arr
    }
    var day = str.componentsSeparatedByString("/") as Array<String>
    for item in day{
        arr[Int(item)!] = true
    }
    return arr
}

func arrToDay(arr:Array<Int>)->Array<Bool>{
    var newArr = Array<Bool>(count: 31, repeatedValue: false)
    for item in arr{
        newArr[item] = true
    }
    return newArr
}

/********************************************************/

class Node {
    init (i:String,r:Int,cal:NSArray){
        instructor_ = i
        rate_ = r
        cal_ = cal
    }
    var instructor_:String!
    var rate_:Int!
    var cal_:NSArray!
}

/********************************************************/
//var try:Array<String>!



var main:Main!

var date:NSArray!

//let courses = NSDictionary(contentsOfURL: NSBundle.mainBundle().URLForResource("course", withExtension: "plist")!)!
var courses:NSDictionary!

var classID:String!

var classCode:String!

//let className:NSDictionary = NSDictionary(contentsOfURL: NSBundle.mainBundle().URLForResource("className", withExtension: "plist")!)!

var classes:Array<NSMutableDictionary>!

var schedule:Array<Array<Bool> >!

var currUser:String!
var userID:Int!

var tempArr:NSArray!
var currNode:Node!
var numOfDays = 0
var thisUser:NSMutableDictionary!

var dateForm = NSDateFormatter()

//let mainURL = "http://localhost/phpmyadmin/sqlite/"
let mainURL = "http://lazy.roget77.com/laravel4/public/index.php/lazy."
//let mainURL = "http://192.168.110.126/phpmyadmin/sqlite/"


var loc = ["九龙坡":["杨家坪","谢家湾","直港大道"],
    "沙坪坝":["沙坪坝","杨公桥","大学城"],
    "江北":["观音桥","五里店","大新村"]]

var myCoursesInfo:Array<Array<String>>!

extension NSMutableData {
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}