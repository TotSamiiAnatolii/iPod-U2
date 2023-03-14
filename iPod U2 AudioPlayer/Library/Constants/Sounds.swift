//
//  Sounds.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import Foundation

enum Sounds {
  
    static var track1: URL {
        guard let path = Bundle.main.path(forResource: "liam_m-i-know", ofType: "mp3") else {
            return URL(fileURLWithPath: "")}
        
        return URL(fileURLWithPath: path)
    }
}
