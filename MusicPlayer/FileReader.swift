//
//  FileReader.swift
//  MusicPlayer
//
//  Created by Monzy on 15/10/28.
//  Copyright © 2015年 Monzy. All rights reserved.
//

import UIKit

class FileReader: NSObject {
    class func readFiles() -> [String]{
        return NSBundle.mainBundle().pathsForResourcesOfType("mp3", inDirectory: nil)
    }
}
