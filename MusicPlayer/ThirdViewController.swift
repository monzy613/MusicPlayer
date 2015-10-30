//
//  ThirdViewController.swift
//  PageMenu
//
//  Created by Monzy on 15/10/27.
//  Copyright © 2015年 Monzy. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet var consoleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let console = DebugClass.console {
            consoleLabel.text = console
        } else {
            consoleLabel.text = "no console"
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "console:", name: "inDeviceDebug", object: nil)

        // Do any additional setup after loading the view.
    }
    
    func console(notification: NSNotification) {
        let log = notification.object as! String
        consoleLabel.text = log
        print("[inDeviceDebug]\(log)")
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
