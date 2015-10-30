//
//  DebugClass.swift
//  MusicPlayer
//
//  Created by Monzy on 15/10/30.
//  Copyright © 2015年 Monzy. All rights reserved.
//

import UIKit

class DebugClass: NSObject {
    static var console: String? {
        didSet {
            NSNotificationCenter.defaultCenter().postNotificationName("inDeviceDebug", object: console)
        }
    }
}
