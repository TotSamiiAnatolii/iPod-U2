//
//  ModelProgressTrack.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import UIKit

struct ModelProgressTrack {
    
    var currentTime: CGFloat
    
    var currentDuration: CGFloat
    
    var maxDuration: CGFloat
    
    var stateCurrent: StatePlayer

    var progress: CGFloat {
        return (currentTime * 100) / maxDuration
    }
    
    var endTrack: Bool {
     
        return Int(currentDuration) == 0 ? true : false
    }
}
