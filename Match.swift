//
//  Match.swift
//  bridge
//
//  Created by 钟镇阳 on 6/14/15.
//  Copyright (c) 2015 钟镇阳. All rights reserved.
//

import UIKit

class Match: UIViewController {

    @IBOutlet var day: UILabel!
    var text:String!
    var pageIndex:Int!
    @IBOutlet var table: MatchTBV!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        day.text = text
        table.index = pageIndex
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
