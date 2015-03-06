//
//  TodayViewController.swift
//  whichStepExtension
//
//  Created by apple on 15/1/4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    //点击打开应用的事件
    @IBAction func enter(sender: AnyObject) {
        println("....")
        var url = NSURL(string: "SheSchemes://enter")
        extensionContext?.openURL(url!, completionHandler: nil)
    }
    @IBOutlet var xinglabel: UILabel!
    @IBOutlet var minglabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let userdefault = NSUserDefaults(suiteName: "group.com.yiyun.seenow")
        
        self.xinglabel.text = userdefault?.valueForKey("xing") as String
        self.minglabel.text = userdefault?.valueForKey("ming") as String
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
}
