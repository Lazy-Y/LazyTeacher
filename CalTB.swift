//
//  try.swift
//  bridge
//
//  Created by 钟镇阳 on 6/11/15.
//  Copyright (c) 2015 钟镇阳. All rights reserved.
//

import UIKit

class CalTB: UIViewController {

    @IBOutlet var table: CalTBV!
    
    @IBOutlet var label: UILabel!
    var text = ""
    var pageIndex:Int!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        label.text = text
        table.page = pageIndex
        table.parent = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
