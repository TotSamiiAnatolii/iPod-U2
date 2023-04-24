//
//  PlayerIPod.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import AVFoundation

final class PlayerIPod {
    
    static let shared = PlayerIPod()
    
    private var model = ModelProgressTrack(
        currentTime: 0,
        currentDuration: 0,
        maxDuration: 0,
        stateCurrent: .play)
    
    private var playerItem: AVPlayerItem?
    
    private var audioPlayer = AVQueuePlayer()
    
    private var duration: CMTime = CMTime()
    
    private var seconds: CGFloat = 0.0
    
    fileprivate let seekDuration: Float64 = 10
    
    public var statePlayer: StatePlayer = .play {
        didSet {
            switch statePlayer {
            case .pause:
                self.pauseIPod()
            case .play:
                self.playIPod()
            }
        }
    }
    
    private init() {
        
    }
    
    public func setButtonTapSound(sound: URL) {
        playerItem = AVPlayerItem(url: sound)
        audioPlayer = AVQueuePlayer(playerItem: playerItem)
        setNewValuePlayerItem()
        audioPlayer.play()
    }
    
    public func replaceTrack(track: URL) {
        playerItem = nil
        playerItem = AVPlayerItem(url: track)
        
        self.audioPlayer.removeAllItems()
        self.audioPlayer.replaceCurrentItem(with: playerItem)
        setNewValuePlayerItem()
    }
    
    private func setNewValuePlayerItem() {
        guard let playerItem = playerItem else {
            return
        }
        duration = playerItem.asset.duration
        seconds = CMTimeGetSeconds(duration)
    }
    
    private func playIPod() {
        audioPlayer.play()
    }
    
    private func pauseIPod() {
        audioPlayer.pause()
    }
    
    func buttonGoToBackSec() {
        let playerCurrenTime = CMTimeGetSeconds(audioPlayer.currentTime())
        var newTime = playerCurrenTime - seekDuration
        if newTime < 0 { newTime = 0 }
        audioPlayer.pause()
        let selectedTime: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
        audioPlayer.seek(to: selectedTime)
        
        switch statePlayer {
        case .pause:
            audioPlayer.pause()
        case .play:
            audioPlayer.play()
        }
    }
    
    func buttonForwardSec() {
        if let duration  = audioPlayer.currentItem?.duration {
            let playerCurrentTime = CMTimeGetSeconds(audioPlayer.currentTime())
            let newTime = playerCurrentTime + seekDuration
            if newTime < CMTimeGetSeconds(duration) {
                let selectedTime: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
                audioPlayer.seek(to: selectedTime)
            }
            switch statePlayer {
            case .pause:
                audioPlayer.pause()
            case .play:
                audioPlayer.play()
            }
        }
    }
    
    func updateProgress(complition: @escaping ((ModelProgressTrack) -> Void)) {
        
        self.audioPlayer.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in
            
            if self.audioPlayer.currentItem?.status == .readyToPlay {
                let time : CGFloat = CMTime.seconds
                
                self.model.currentTime = time
                self.model.currentDuration = self.seconds - time
                self.model.maxDuration = self.seconds
                self.model.stateCurrent = self.statePlayer
                
                complition(self.model)
            }
        }
    }
}
