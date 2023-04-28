//
//  CGFloat+.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import UIKit

extension CGFloat {
    
    var degrees:CGFloat {
        return self * 180 / CGFloat(π)
    }
    var radians:CGFloat {
        return self * CGFloat(π) / 180
    }

    func stringFromTimeInterval() -> String {
        let interval = Int(self)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        return String(format: "%1d:%02d",  minutes, seconds)
    }
}
