//
//  PlayerViewController.swift
//  MusicPlayer
//
//  Created by Monzy on 15/10/28.
//  Copyright © 2015年 Monzy. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {
    
    
    var timer: NSTimer?
    var player: MP3Player?
    var isPlaying = false
    var isSliding = false
    @IBOutlet var trackTimeLabel: UILabel!
    @IBOutlet var playOrPauseButton: UIButton!
    @IBOutlet var progressSlider: UISlider!
    
    
    
    @IBAction func startSliding(sender: UISlider) {
        print("start sliding")
        isSliding = true
    }
   
    @IBAction func endSliding(sender: UISlider) {
        print("end sliding inside")
        endEditingProgress(progressSlider.value)
    }
    
    @IBAction func endSlidingOut(sender: UISlider) {
        print("end sliding outside")
        endEditingProgress(progressSlider.value)
    }
    
    func endEditingProgress(newProgress: Float) {
        isSliding = false
        player?.setProgress(newProgress)
        updateView()
        switchPlay(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FileOperator.makeMusicDir()
        setMusicThumbImage()
        trackTimeLabel.text = "00:00"
        player = MP3Player()
        startTimer()
    }
    
    private func setMusicThumbImage() {
        let tmpImage = UIImage(named: "musicSliderThumbImage")
        let musicThumbImage = UIImage(data: UIImagePNGRepresentation(tmpImage!)!, scale: 1.4)
        progressSlider.setThumbImage(musicThumbImage, forState: .Normal)
    }

    @IBAction func playButtonPressed(sender: UIButton) {
        if isPlaying {
            player?.playOrPause(false)
        } else {
            player?.playOrPause(true)
        }
        switchPlay(!isPlaying)
    }
    
    @IBAction func nextButtonPressed(sender: UIButton) {
        trackTimeLabel.text = "00:00"
        switchPlay(true)
        player?.next()
    }
    
    @IBAction func preButtonPressed(sender: UIButton) {
        trackTimeLabel.text = "00:00"
        switchPlay(true)
        player?.previous()
    }
    
    @IBAction func returnSomeSeconds(sender: UIButton) {
        switchPlay(true)
        player?.returnWithSeconds(10)
        updateView()
    }
    
    @IBAction func forwardSomeSeconds(sender: UIButton) {
        switchPlay(true)
        player?.forwardWithSeconds(10)
        updateView()
    }
    
    func switchPlay (play: Bool) {
        isPlaying = play
        if play {
            startTimer()
            playOrPauseButton.setImage(UIImage(named: "pause_green"), forState: .Normal)
        } else {
            timer?.invalidate()
            playOrPauseButton.setImage(UIImage(named: "play_green"), forState: .Normal)
        }
    }
    
    func startTimer() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateView", userInfo: nil, repeats: true)
    }
    
    func updateView() {
        let minutes: Int = Int((player?.getCurrentTime())!) / 60
        let seconds: Int = Int((player?.getCurrentTime())!) % 60
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
        
        if isSliding == false {
            progressSlider.value = (player?.getProgress())!
        }
        trackTimeLabel.text = timeString
    }
    
}
