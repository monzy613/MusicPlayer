//
//  ToolSet.swift
//  MusicPlayer
//
//  Created by Monzy on 15/10/28.
//  Copyright © 2015年 Monzy. All rights reserved.
//

import UIKit

class ToolSet: NSObject {
    class func getTimeString(timeFloatValue: Float) -> String {
        let minutes: Int = Int(timeFloatValue) / 60
        let seconds: Int = Int(timeFloatValue) % 60
        var timeString = ""
        if minutes >= 10 {
            timeString += "\(minutes)"
        } else {
            timeString += "0\(minutes)"
        }
        
        if seconds >= 10 {
            timeString += ":\(seconds)"
        } else {
            timeString += ":0\(seconds)"
        }
        return timeString
    }
}
