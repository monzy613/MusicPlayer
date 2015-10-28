//
//  MP3Player.swift
//  MusicPlayer
//
//  Created by Monzy on 15/10/28.
//  Copyright © 2015年 Monzy. All rights reserved.
//

import UIKit
import AVFoundation

class MP3Player: NSObject, AVAudioPlayerDelegate {
    var player: AVAudioPlayer?
    var currentTrackIndex = 0
    var tracks = [String]()
    
    override init() {
        tracks = FileOperator.getMp3FilePath()
        print(tracks)
        super.init()
        queueTrack()
    }
    
    func queueTrack() {
        if player != nil {
            player = nil
        }
        
        let url = NSURL.fileURLWithPath(tracks[currentTrackIndex])
        do {
            self.player = try AVAudioPlayer(contentsOfURL: url)
        }
        catch {
            print("fatal error: \(error)")
            return
        }
        
        player?.delegate = self
        player?.prepareToPlay()
    }
    
    func playOrPause(play: Bool) {
        if player == nil {
            return
        }
        
        if play {
            player?.play()
        } else {
            player?.pause()
        }
        
    }
    
    func next() {
        if currentTrackIndex == (tracks.count - 1) {
            currentTrackIndex = 0
        } else {
            currentTrackIndex += 1
        }
        queueTrack()
        player?.play()
    }
    
    func previous() {
        if currentTrackIndex == 0 {
            currentTrackIndex = tracks.count - 1
        } else {
            currentTrackIndex -= 1
        }
        queueTrack()
        player?.play()
    }
    
    func returnWithSeconds(seconds: Float) {
        if getCurrentTime() > seconds {
            print("print at time \(getCurrentTime() - seconds)")
            player?.currentTime = Double(getCurrentTime() - seconds)
        } else {
            player?.currentTime = 0
        }
        player?.play()
    }
    
    func forwardWithSeconds(seconds: Float) {
        if getCurrentTime() + seconds < getDuration() {
            print("print at time \(getCurrentTime() + seconds)")
            player?.currentTime = Double(getCurrentTime() + seconds)
        } else {
            next()
        }
        player?.play()
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        next()
    }
    
    func setProgress(newProgress: Float) {
        player?.currentTime = Double(getDuration() * newProgress)
        player?.play()
    }
    
    func getProgress() -> Float {
        if player != nil {
            return Float((player?.currentTime)!) / Float((player?.duration)!)
        } else {
            return -1.0
        }
    }
    
    func getDuration() -> Float {
        return Float((player?.duration)!)
    }
    
    func getCurrentTime() -> Float {
        return Float((player?.currentTime)!)
    }

}
