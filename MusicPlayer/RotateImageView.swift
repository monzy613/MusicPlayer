//
//  RotateImageView.swift
//  MusicPlayer
//
//  Created by Monzy on 15/10/29.
//  Copyright © 2015年 Monzy. All rights reserved.
//

import UIKit
import CoreGraphics

class RotateImageView: SpringImageView {
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var blurView: UIVisualEffectView?
    var timer: NSTimer?
    var rotateParameter: Double = 1000
    var isRotating = false
    var currentAngle: CGFloat = 0
    
    func openBlur() {
        self.blurView = nil
        if self.blurView == nil {
            self.blurView = UIVisualEffectView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
            self.blurView?.effect = UIBlurEffect(style: .Light)
            self.blurView?.layer.cornerRadius = self.frame.width / 2
        }
        self.addSubview(blurView!)
        self.blurView?.clipsToBounds = true
    }
    
    func closeBlur() {
        blurView?.removeFromSuperview()
    }
    
    func startRotating() {
        if isRotating {
            return
        }
        isRotating = true
        if superview != nil {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.003, target: self, selector: "rotateImageView", userInfo: nil, repeats: true)
        }
    }
    
    func stopRotating() {
        if isRotating == false {
            return
        }
        isRotating = false
        timer?.invalidate()
    }
    
    func refreshRotate() {
        transform = CGAffineTransformMakeRotation(currentAngle)
    }
    
    func rotateImageView() {
        transform = CGAffineTransformMakeRotation(currentAngle)
        currentAngle += CGFloat(M_PI) / CGFloat(rotateParameter)
    }
    
}
