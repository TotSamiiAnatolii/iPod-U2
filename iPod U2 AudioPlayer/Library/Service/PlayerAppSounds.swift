//
//  PlayerAppSounds.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import Foundation
import AVFoundation

final class PlayerAppSounds {
    
    static let shared = PlayerAppSounds()
    
    private var audioPlayer = AVAudioPlayer()
    
    private init() {
        
    }
    
    static var click: URL {
       guard let path = Bundle.main.path(forResource: "schelchok-vyiklyucheniya", ofType: "mp3") else {return URL(fileURLWithPath: "")}
       
       return URL(fileURLWithPath: path)
   }
    
    public func setSounds(url: URL) {
        
        do {
           audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.play()
        } catch {
            print(error.localizedDescription)
        }
    }
}
