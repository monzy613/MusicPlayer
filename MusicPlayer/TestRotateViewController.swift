//
//  TestRotateViewController.swift
//  MusicPlayer
//
//  Created by Monzy on 15/10/29.
//  Copyright © 2015年 Monzy. All rights reserved.
//

import UIKit

class TestRotateViewController: UIViewController {

    @IBOutlet var rotateImageView: RotateImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        rotateImageView.rotateParameter = 1200
        rotateImageView.startRotating()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addBlur(sender: UIButton) {
        rotateImageView.openBlur()
    }
    
    @IBAction func removeBlur(sender: UIButton) {
        rotateImageView.closeBlur()
    }
    
    @IBAction func slideUp(sender: UIButton) {
        rotateImageView.animation = "slideUp"
        rotateImageView.animate()
    }

    @IBAction func slideDown(sender: UIButton) {
        rotateImageView.animation = "slideDown"
        rotateImageView.animate()
    }
    
    @IBAction func `switch`(sender: UIButton) {
        if rotateImageView.isRotating {
            rotateImageView.stopRotating()
        } else {
            rotateImageView.startRotating()
        }
    }

    @IBAction func startRotating(sender: UIButton) {
        rotateImageView.startRotating()
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
