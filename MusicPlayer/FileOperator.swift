//
//  FileOperator.swift
//  MusicPlayer
//
//  Created by Monzy on 15/10/28.
//  Copyright © 2015年 Monzy. All rights reserved.
//

import UIKit

class FileOperator: NSObject {
    
    static private var fileManager = NSFileManager.defaultManager()
    
    static private var musicDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] + "/Musics/"
    

    class func readFiles() -> [String]{
        getMp3FilePath()
        return NSBundle.mainBundle().pathsForResourcesOfType("mp3", inDirectory: nil)
    }
    
    class func makeMusicDir() {
        let documentPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let newDirectory = "\(documentPath[0])/Musics"
        print("directory: \(newDirectory)")
        do {
            try fileManager.createDirectoryAtPath(newDirectory, withIntermediateDirectories: false, attributes: nil)
        }
        catch {
            print("makeMusicDir Error \(error)")
        }
    }
    
     class func getMp3FilePath() -> [String] {
        var musicPaths = [String]()
        var filenames  = [String]()
        do {
            filenames = try fileManager.contentsOfDirectoryAtPath(musicDirectory)
        } catch {
            print("error at getMp3FilePath()")
        }
        for filename in filenames {
            if isExtensionEqualTo("mp3", filename: filename) {
                musicPaths.append("\(musicDirectory)\(filename)")
                print("new mp3 added: \(musicDirectory)\(filename)")
            }
        }
        
        return musicPaths
    }
    
    private static func isExtensionEqualTo(equalTo: String, filename: String) -> Bool {
        let fileExtName = (filename as NSString).pathExtension.lowercaseString
        return fileExtName == equalTo
    }
 }