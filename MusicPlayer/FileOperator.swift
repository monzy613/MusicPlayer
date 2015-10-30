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
    
    class func makeMusicDir() {
        let documentPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let newDirectory = "\(documentPath[0])/Musics"
        print("MusicDirectory: |||\(musicDirectory)|||")

        do {
            try fileManager.createDirectoryAtPath(newDirectory, withIntermediateDirectories: false, attributes: nil)
        }
        catch {

        }
    }
    
    class func storeMusicWithPath(path: String) {
        //file:///private/var/mobile/Containers/Data/Application/xxxxxx/.nextToYou.mp3
        do {
            var pathComponents = (path as NSString).pathComponents
            let filename = (path as NSString).lastPathComponent
            pathComponents.removeFirst()
            pathComponents.removeFirst()
            pathComponents.insert("/", atIndex: 0)
            let srcPath = NSString.pathWithComponents(pathComponents)
            let destPath = "\(musicDirectory)\(filename)"
            try fileManager.moveItemAtPath(srcPath, toPath: destPath)
            DebugClass.console = "file [\(filename)] received"
        }
        catch {
            DebugClass.console = "move item exception: \(error)"
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
