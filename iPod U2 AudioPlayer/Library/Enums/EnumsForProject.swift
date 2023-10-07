//
//  EnumsForProject.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import Foundation

enum ButtonPlayer: String {
    case menu = "MENU"
    case playPause = "pause-pause"
    case right = "rightButton"
    case left = "leftButton"
    case select = "select"
    case forward
    case back
}

enum StatePlayer {
    case pause
    case play
}

enum ScreenTitle: String {
    case selectTrack = "Soungs"
    case player = "Now playing"
}
