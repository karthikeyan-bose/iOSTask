//
//  VideoTableViewCell.swift
//  InfiniteScroll
//
//  Created by Karthikeyan 
//

import UIKit
import AVKit

class VideoTableViewCell: UITableViewCell {
    
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var isPlaying = false
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with video: Video)  {
        
        playerLayer?.removeFromSuperlayer()
        player = nil
        
        player = AVPlayer(url: video.videoURL)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.width)
        playerLayer?.position = CGPoint(x: contentView.frame.width/2, y: contentView.frame.height/2)
        contentView.layer.addSublayer(playerLayer!)
        player?.play()
    }
    
    
    func play() {
        if !isPlaying {
            player?.play()
            isPlaying = true
        }
    }
    
    func pause() {
        if isPlaying {
            player?.pause()
            isPlaying = false
        }
    }

    
    override func prepareForReuse() {
        super.prepareForReuse()
        player?.pause()
        player = nil
        playerLayer?.removeFromSuperlayer()
        playerLayer = nil
    }

}
