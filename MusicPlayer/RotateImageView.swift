//
//  RotateImageView.swift
//  MusicPlayer
//
//  Created by Monzy on 15/10/29.
//  Copyright © 2015年 Monzy. All rights reserved.
//

import UIKit
import CoreGraphics

class RotateImageView: UIImageView {
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var timer: NSTimer?
    var rotateParameter: Double = 1000
    var isRotating = false
    var currentAngle: CGFloat = 0
    
    func startRotating() {
        if isRotating {
            return
        }
        isRotating = true
        if superview != nil {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.003, target: self, selector: "rotate", userInfo: nil, repeats: true)
        }
    }
    
    func stopRotating() {
        if isRotating == false {
            return
        }
        isRotating = false
        timer?.invalidate()
    }
    
    func rotate() {
        transform = CGAffineTransformMakeRotation(currentAngle)
        currentAngle += CGFloat(M_PI) / CGFloat(rotateParameter)
    }
}
