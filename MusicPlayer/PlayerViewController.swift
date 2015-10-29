//
//  PlayerViewController.swift
//  MusicPlayer
//
//  Created by Monzy on 15/10/28.
//  Copyright © 2015年 Monzy. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var timer: NSTimer?
    var player: MP3Player?
    var isPlaying = false
    var isSliding = false
    @IBOutlet var currentTimeLabel: UILabel!
    @IBOutlet var durationTimeLabel: UILabel!
    @IBOutlet var trackNameLabel: UILabel!
    @IBOutlet var playOrPauseButton: UIButton!
    @IBOutlet var progressSlider: UISlider!
    @IBOutlet var preTrackButton: UIButton!
    @IBOutlet var nextTrackButton: UIButton!
    @IBOutlet var returnButton: UIButton!
    @IBOutlet var forwardButton: UIButton!
    @IBOutlet var musicListTableView: UITableView!
    
    
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
    
    func setNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setTrackInfo:", name: "SetDuration", object: nil)
    }
    
    func setTrackInfo(notification: NSNotification) {
        let trackInfo = notification.object as! [String: String]
        print("setTrackInfo:(\(trackInfo))")
        durationTimeLabel.text = trackInfo["Duration"]
        trackNameLabel.text = trackInfo["TrackName"]
    }
    
    func addPageView() {
        let pageRootViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RootPageViewController")
        pageRootViewController?.view.frame = CGRect(x: 0, y: 20, width: self.view.frame.width, height: self.view.frame.height - 20 - 4 * 8 - trackNameLabel.frame.height - playOrPauseButton.frame.height - progressSlider.frame.height)
        self.addChildViewController(pageRootViewController!)
        self.view.addSubview((pageRootViewController?.view)!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //musicListTableView.delegate = self
        //musicListTableView.dataSource = self
        addPageView()
        setNotification()
        FileOperator.makeMusicDir()
        setMusicThumbImage()
        currentTimeLabel.text = "00:00"
        durationTimeLabel.text = "00:00"
        player = MP3Player()
        if player?.trackCount == 0 {
            print("No track")
            trackNameLabel.text = "No Track"
            setWidgetEnabled(false)
            return
        }
        startTimer()
    }
    
    private func setWidgetEnabled(isEnable: Bool) {
        returnButton.enabled = isEnable
        preTrackButton.enabled = isEnable
        playOrPauseButton.enabled = isEnable
        nextTrackButton.enabled = isEnable
        forwardButton.enabled = isEnable
        progressSlider.enabled = isEnable
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
        currentTimeLabel.text = "00:00"
        switchPlay(true)
        player?.next()
    }
    
    @IBAction func preButtonPressed(sender: UIButton) {
        currentTimeLabel.text = "00:00"
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
        currentTimeLabel.text = ToolSet.getTimeString((player?.getCurrentTime())!)
        if !isSliding {
            progressSlider.value = (player?.getProgress())!
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (player?.trackCount)!
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MusicListCell") as! MusicListCellTableViewCell
        cell.configureCellWithTrackInfo("\((player?.trackNames[indexPath.row])!)", _trackIndex: indexPath.row)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        musicListTableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}
