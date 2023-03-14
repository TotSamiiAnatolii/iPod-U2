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
    var rad2deg:CGFloat {
        return self.degrees
    }
    var deg2rad:CGFloat {
        return self.radians
    }
}
