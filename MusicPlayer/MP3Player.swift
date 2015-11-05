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
    static var instance: MP3Player?
    var player: AVAudioPlayer?
    var currentTrackIndex = 0
    var tracks = [String]()
    var trackNames = [String]()
    var trackAVURLAssets = [AVURLAsset]()
    var trackCount = 0
    
    override init() {
        tracks = FileOperator.getMp3FilePath()
        super.init()
        trackCount = tracks.count
        MP3Player.instance = self
        if tracks.count == 0 {
            return
        }
        getTrackAssets(tracks)
        getTrackNames()
        queueTrack()
    }
    
    func refreshTracks() {
        let previousCount = trackCount
        tracks = FileOperator.getMp3FilePath()
        getTrackAssets(tracks)
        trackCount = tracks.count
        getTrackNames()
        if previousCount == 0 {
            queueTrack()
            NSNotificationCenter.defaultCenter().postNotificationName("SetWidgetEnabled", object: true)
        }
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
        if let duration = player?.duration {
            let durationString = ToolSet.getTimeString(Float(duration))
            print("duration: \(durationString)")
            NSNotificationCenter.defaultCenter().postNotificationName("SetTrackInfo", object: [
                "Duration": durationString,
                "TrackName": ((tracks[currentTrackIndex] as NSString).stringByDeletingPathExtension as NSString).lastPathComponent
                ])
        } else {
            print("duration is nil")
        }
    }

    func getTrackAssets(withPaths: [String]) {
        trackAVURLAssets.removeAll()
        for path in withPaths {
            let musicUrl = NSURL(fileURLWithPath: path)
            let mp3Asset = AVURLAsset(URL: musicUrl)
            trackAVURLAssets.append(mp3Asset)
        }
    }
    
    func getArtworkForTrack(trackNumber: Int) -> NSData? {
        if trackNumber >= trackCount {
            return nil
        }
        let asset = trackAVURLAssets[trackNumber]
        var artworkData: NSData = NSData()
        var isArtworkAvailable = false
        
        for format in asset.availableMetadataFormats {
            for metadata in asset.metadataForFormat(format) {
                if metadata.commonKey == "artwork" {
                    artworkData = metadata.value as! NSData
                    isArtworkAvailable = true
                }
            }
        }
        
        if isArtworkAvailable {
            return artworkData
        } else {
            return nil
        }
    }
    
    func playOrPause(play: Bool) {
        if player == nil {
            return
        }
        
        if play {
            NSNotificationCenter.defaultCenter().postNotificationName("PlayToRotate", object: nil)
            player?.play()
        } else {
            NSNotificationCenter.defaultCenter().postNotificationName("PauseToStopRotate", object: nil)
            player?.pause()
        }
        
    }
    
    func playWithTrackIndex(trackIndex: Int) {
        if trackIndex < trackCount {
            currentTrackIndex = trackIndex
            if player?.playing == false {
                NSNotificationCenter.defaultCenter().postNotificationName("PlayToRotate", object: nil)
            }
            queueTrack()
            player?.play()
        }
    }
    
    private func getTrackNames() {
        trackNames = []
        for pathName in tracks {
            trackNames.append(((pathName as NSString).stringByDeletingPathExtension as NSString).lastPathComponent)
        }
    }
    
    func next() {
        if player?.playing == false {
            NSNotificationCenter.defaultCenter().postNotificationName("PlayToRotate", object: nil)
        }
        if currentTrackIndex == (tracks.count - 1) {
            currentTrackIndex = 0
        } else {
            currentTrackIndex += 1
        }
        queueTrack()
        player?.play()
    }
    
    func previous() {
        if player?.playing == false {
            NSNotificationCenter.defaultCenter().postNotificationName("PlayToRotate", object: nil)
        }
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
        NSNotificationCenter.defaultCenter().postNotificationName("PlayToRotate", object: nil)
        player?.play()
    }
    
    func forwardWithSeconds(seconds: Float) {
        if getCurrentTime() + seconds < getDuration() {
            print("print at time \(getCurrentTime() + seconds)")
            player?.currentTime = Double(getCurrentTime() + seconds)
        } else {
            next()
        }
        NSNotificationCenter.defaultCenter().postNotificationName("PlayToRotate", object: nil)
        player?.play()
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        next()
    }
    
    func setProgress(newProgress: Float) {
        player?.currentTime = Double(getDuration() * newProgress)
        NSNotificationCenter.defaultCenter().postNotificationName("PlayToRotate", object: nil)
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
