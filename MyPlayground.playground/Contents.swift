//: Playground - noun: a place where people can play

import UIKit

func getExtName(filename: String) -> String {
    var extName = ""
    var lastIndex = filename.characters.count
    
    for var i = lastIndex - 1; i >= 0; --i {
        var ch = (filename as NSString).substringWithRange(NSMakeRange(i, 1))
        if ch == "." {
            return extName
        } else {
            extName = ch + extName
        }
    }
    return extName
}

getExtName("secret base ～君がくれたもの～.mp3")
//var str = "secret base ～君がくれたもの～.mp3"
var str = ""

var nsstr = "secret base ～君がくれたもの～.mp3" as NSString

nsstr.pathExtension