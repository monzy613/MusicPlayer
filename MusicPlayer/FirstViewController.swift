//
//  FirstViewController.swift
//  PageMenu
//
//  Created by Monzy on 15/10/27.
//  Copyright © 2015年 Monzy. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate {

    
    
    var trackTableViewDelegate: UITableViewDelegate?
    var trackTableViewDataSource: UITableViewDataSource?
    @IBOutlet var trackTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        trackTableView.delegate = trackTableViewDelegate
        trackTableView.dataSource = trackTableViewDataSource
        setNotification()
    }
    
    func setNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadData", name: "ReloadData", object: nil)
    }
    
    func reloadData() {
        MP3Player.instance?.refreshTracks()
        trackTableView?.reloadData()
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
