//
//  TrackListCell.swift
//  MusicPlayer
//
//  Created by Monzy on 15/10/31.
//  Copyright © 2015年 Monzy. All rights reserved.
//

import UIKit

class TrackListCell: UITableViewCell {

    var trackIndex: Int?
    var trackName: String?
    @IBOutlet var trackNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCellWithTrackInfo(_trackName: String, _trackIndex: Int) {
        trackName = _trackName
        trackIndex = _trackIndex
        trackNameLabel.text = "\(trackIndex!). \(trackName!)"
    }

}
