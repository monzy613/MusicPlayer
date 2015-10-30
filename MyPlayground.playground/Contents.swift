//: Playground - noun: a place where people can play

import UIKit
//
//func getExtName(filename: String) -> String {
//    var extName = ""
//    var lastIndex = filename.characters.count
//    
//    for var i = lastIndex - 1; i >= 0; --i {
//        var ch = (filename as NSString).substringWithRange(NSMakeRange(i, 1))
//        if ch == "." {
//            return extName
//        } else {
//            extName = ch + extName
//        }
//    }
//    return extName
//}
//
//getExtName("secret base ～君がくれたもの～.mp3")
////var str = "secret base ～君がくれたもの～.mp3"
//var str = ""
//
//var nsstr = "secret base ～君がくれたもの～.mp3" as NSString
//
//nsstr.pathExtension
//
//
//(("/Uesrs/apple/testfile.txt" as NSString).stringByDeletingPathExtension as NSString).lastPathComponent

var pathComponents = ("file:///private/var/mobile/Containers/Data/Application/xxxxxx/.nextToYou.mp3" as NSString).pathComponents
pathComponents.removeFirst()
pathComponents.removeFirst()
pathComponents.insert("/", atIndex: 0)
pathComponents.last
let path = NSString.pathWithComponents(pathComponents)