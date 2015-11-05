//
//  SecondViewController.swift
//  PageMenu
//
//  Created by Monzy on 15/10/27.
//  Copyright © 2015年 Monzy. All rights reserved.
//

import UIKit

@IBDesignable
class SecondViewController: UIViewController {

    var percent: Float = 0.9
    var trackImageView: RotateImageView?
    var trackImage: UIImage?
    let defaultTrackImage = UIImage(named: "defaultTrackIcon")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTrackImage()
        trackImageView?.rotateParameter = 3000
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshTrackImage", name: "SetTrackInfo", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "turnOnRotating", name: "PlayToRotate", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "turnOffRotating", name: "PauseToStopRotate", object: nil)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        if MP3Player.instance?.player?.playing == true {
            turnOnRotating()
            trackImageView?.awakeFromNib()
        }
        trackImageView?.animation = "slideDown"
        trackImageView?.animate()
    }
    
    override func viewWillDisappear(animated: Bool) {
        
    }
    
    func turnOnRotating() {
        trackImageView?.startRotating()
    }
    
    func turnOffRotating() {
        trackImageView?.stopRotating()
    }


    func initTrackImage() {
        trackImageView = RotateImageView()
        view.addSubview(trackImageView!)
        refreshTrackImage()
        let superViewFrame = view.frame
        let superWidth = Float(superViewFrame.width)
        let superHeight = Float(superViewFrame.height)
        var rootWidth: Float
        if superWidth > superHeight {
            rootWidth = superHeight
        } else {
            rootWidth = superWidth
        }
        
        let imageWidth = CGFloat(rootWidth * 0.9)
        let midX = superViewFrame.midX
        let midY = superViewFrame.midY
        let startX: CGFloat = midX - imageWidth / 2
        let startY: CGFloat = 20
        trackImageView!.contentMode = .ScaleAspectFill
        trackImageView!.frame = CGRectMake(startX, startY, imageWidth, imageWidth)
        trackImageView!.layer.masksToBounds = true
        trackImageView?.layer.cornerRadius = imageWidth / 2
    }
    
    
    /*
    key: artist, value: Optional(陈奕迅)
    key: albumName, value: Optional(1997-2007跨世纪国语精选)
    key: title, value: Optional(淘汰)
    key: artwork, value: Optional(
    */
    
    func refreshTrackImage() {
        if MP3Player.instance != nil {
            trackImage = nil
            if let trackNumber = MP3Player.instance?.currentTrackIndex {
                if let artworkData = MP3Player.instance?.getArtworkForTrack(trackNumber) {
                    trackImage = UIImage(data: artworkData)
                    trackImageView?.image = trackImage
                } else {
                    trackImageView?.image = defaultTrackImage
                }
                UIView.animateWithDuration(0.01, animations: {
                    self.trackImageView?.layoutIfNeeded()
                })
            }
        }
    }
    
    
    override func viewWillLayoutSubviews() {
        refreshTrackImage()
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
