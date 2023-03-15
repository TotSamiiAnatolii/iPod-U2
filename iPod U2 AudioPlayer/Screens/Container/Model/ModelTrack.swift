//
//  ModelTrack.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import UIKit

struct ModelTrack {
    
    let id: UUID

    let nameTrack: String
    
    let namePerformer: String
    
    let nameAlbum: String
    
    let track: URL
    
    let image: UIImage
    
    var isSelected = false
}
