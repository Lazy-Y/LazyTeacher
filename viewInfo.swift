//
//  info.swift
//  bridge
//
//  Created by 钟镇阳 on 6/4/15.
//  Copyright (c) 2015 钟镇阳. All rights reserved.
//

import UIKit

class viewInfo: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var b:String!
    var e:String!
    
    @IBOutlet var Email: UITextField!
    
    @IBOutlet var Birth: UITextField!
    
    @IBOutlet var Pass: UITextField!
    
    @IBOutlet var Repass: UITextField!
    
    @IBOutlet var image: UIImageView!
    
    let imagePickerController = UIImagePickerController()
    
    var imageChanged:Bool!
    
    @IBAction func choose(sender: AnyObject) {
        imageChanged = true
        
        imagePickerController.allowsEditing = false
        
        imagePickerController.sourceType = .PhotoLibrary
        
        presentViewController(imagePickerController, animated: true) { () -> Void in}
        
    }
    
    func alertView(View: UIAlertView, clickedButtonAtIndex buttonIndex: Int){
        switch buttonIndex{
            
        case 0:
            return
        case 1:
            var p = View.textFieldAtIndex(0)?.text
            if Int((thisUser["ZPASSWORD"] as! String)) == hash_fun(p!){
                if image.image != nil {
                    var path = saveImage(image.image!)
                }
                var word:Int
                if Pass.text.isEmpty{
                    word = -1
                }
                else {
                    word = hash_fun(Pass.text)
                }
                //var url = NSURL(string: "http://localhost:63342/htdocs/sqlite/viewInfo.php")
                var url = NSURL(string: mainURL+"user.edit")

                var request = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10.0)
                request.HTTPMethod = "POST"
                
                var upload = ""
                if !self.Pass.text.isEmpty && hash_fun(self.Pass.text) != Int((thisUser["ZPASSWORD"] as! String)){
                    if !upload.isEmpty{
                        upload += "&"
                    }
                    upload += "password=" + String(hash_fun(self.Pass.text))
                    thisUser.setValue(hash_fun(self.Pass.text), forKey: "ZPASSWORD")
                }
                if !self.Email.text.isEmpty && self.Email.text != thisUser["ZEMAIL"] as? String{
                    if !upload.isEmpty{
                        upload += "&"
                    }
                    upload += "email=" + Email.text
                    thisUser.setValue(self.Email.text, forKey: "ZEMAIL")
                }
                if !self.Birth.text.isEmpty && Int(self.Birth.text) != Int((thisUser["ZBIRTH"] as! String)){
                    if !upload.isEmpty{
                        upload += "&"
                    }
                    upload += "birth=" + Birth.text
                    thisUser.setValue(Int(self.Birth.text), forKey: "ZBIRTH")
                }/*
                if imageChanged == true {
                    if !upload.isEmpty{
                        upload += "&"
                    }
                    var path = saveImage(image.image!)
                    upload += "image=" + path
                    thisUser.setValue(path, forKey: "ZIMAGE")
                }*/
                if imageChanged == true {
                    myImageUploadRequest(image.image!)
                }
                
                if (upload.isEmpty == false)  {
                    self.dismissViewControllerAnimated(true, completion: nil)
                    return
                }
                var str = thisUser["ZNAME"] as! String
                upload += "&currName=" + str
                //println(upload)
                request.HTTPBody = upload.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
                var resp:NSURLResponse?
                var e:NSError?
                var data: NSData?
                do {
                    data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &resp)
                } catch var error as NSError {
                    e = error
                    data = nil
                }
                if e != nil{
                    UIAlertView(title: "Error", message: e!.localizedDescription , delegate: nil, cancelButtonTitle: "OK").show()
                    return
                }
                var received = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                if received as! String == "noInfo"{
                    UIAlertView(title: "Error", message: "Current user is not fo    und.", delegate: nil, cancelButtonTitle: "OK").show()
                    return
                }
                UIAlertView(title: "Saved", message: "Data have been successfully saved!", delegate: nil, cancelButtonTitle: "OK").show()
                //println(thisUser)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            else {
                UIAlertView(title: "Error", message: "Incorrect password", delegate: nil, cancelButtonTitle: "OK").show()
            }
            return
        default:
            return
        }
    }
    
    @IBAction func save(sender: AnyObject) {

        if !isValidEmail(Email.text){
            UIAlertView(title: "Warning", message: "Email address is not valid", delegate: nil, cancelButtonTitle: "OK").show()
            return
        }
        var year_ : Int
        if let year = Int(Birth.text){
            if (year<1900 || year>2015){
                UIAlertView(title: "Warning", message: "Your birth year is not valid, a valid birth year should be between 1900~2015", delegate: nil, cancelButtonTitle: "OK").show()
                return
            }
            year_ = year
        }
        else {
            UIAlertView(title: "Warning", message: "Birth should be integer, your birth year", delegate: nil, cancelButtonTitle: "OK").show()
            return
        }
        if (Pass.text.isEmpty){
            let alert = UIAlertView(title: "Verify", message: "Please type your original password", delegate: nil, cancelButtonTitle: "Cancel", otherButtonTitles: "OK")
            alert.delegate = self
            
            alert.alertViewStyle = UIAlertViewStyle.SecureTextInput
            
            alert.show()
            return
            
        }
        
        if (Pass.text.characters.count<4 || Pass.text.characters.count>8){
            UIAlertView(title: "Warning", message: "A valid password should contain 4~8 characters", delegate: nil, cancelButtonTitle: "OK").show()
            return
        }
        if Pass.text != Repass.text {
            UIAlertView(title: "Warning", message: "Passwords are not the same", delegate: nil, cancelButtonTitle: "OK").show()
            return
        }
        
        
        let alert = UIAlertView(title: "Verify", message: "Please type your original password", delegate: nil, cancelButtonTitle: "Cancel", otherButtonTitles: "OK")
        alert.delegate = self
        
        alert.alertViewStyle = UIAlertViewStyle.SecureTextInput
        
        alert.show()
    }
    
    func saveImage(selectedImage:UIImage)->String{
        let fileManager = NSFileManager.defaultManager()
        var paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        var filePathToWrite = "\(paths)/SaveFile.jpg"
        var imageData: NSData = UIImagePNGRepresentation(selectedImage)
        fileManager.createFileAtPath(filePathToWrite, contents: imageData, attributes: nil)
        return filePathToWrite
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            image.contentMode = .ScaleAspectFit
            image.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePickerController.delegate = self
        imageChanged = false
        Birth.text = b
        Email.text = e
        self.navigationItem.title = "个人信息"
        self.navigationItem.setRightBarButtonItem(UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.Plain, target: self, action: "save:"), animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func myImageUploadRequest(image:UIImage)
    {
        
        let myUrl = NSURL(string: mainURL+"receiveImage.php");
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "POST";
        
        let param = [
            "name" : thisUser["ZNAME"] as! String
        ]
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let imageData = UIImageJPEGRepresentation(image, 1)
        
        if(imageData==nil) { return; }
        
        request.HTTPBody = createBodyWithParameters(param, filePathKey: "file", imageDataKey: imageData, boundary: boundary)
        print("*******************************")
        print(NSString(data: request.HTTPBody!, encoding: NSUTF8StringEncoding))
        
        var resp:NSURLResponse?
        var err:NSError?
        var data: NSData?
        do {
            data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &resp)
        } catch var error as NSError {
            err = error
            data = nil
        }
        if err != nil {
            print("error=\(err?.description)")
            return
        }
        
        var response = NSString(data: data!, encoding: NSUTF8StringEncoding)
        // You can print out response object
        print("******* response = \(response)")
        
        // Print out reponse body
        let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
        print("****** response data = \(responseString!)")
        
        dispatch_async(dispatch_get_main_queue(),{
        });
        
        /*
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                println("error=\(error)")
                return
            }
            
            // You can print out response object
            println("******* response = \(response)")
            
            // Print out reponse body
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("****** response data = \(responseString!)")
            
            dispatch_async(dispatch_get_main_queue(),{
            });
            
        }
        
        task.resume()*/
        
    }
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        
        var body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("–\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        let filename = (thisUser["ZNAME"] as! String)+".jpg"
        
        let mimetype = "image/jpg"
        
        body.appendString("–\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.appendData(imageDataKey)
        body.appendString("\r\n")
        
        body.appendString("–\(boundary)–\r\n")
        print(NSString(data: body, encoding: NSUTF8StringEncoding))
        return body
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
    }
    
}
