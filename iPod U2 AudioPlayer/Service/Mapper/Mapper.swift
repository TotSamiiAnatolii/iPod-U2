//
//  Parser.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 16.09.2023.
//

import UIKit

protocol MapperProtocol {

    func map(model: ModelTrack, countTrack: (Int, Int)?) -> ModelPlayTrackDisplay
}

final class Mapper: MapperProtocol {
  
    func map(model: ModelTrack, countTrack: (Int, Int)?) -> ModelPlayTrackDisplay {
        let model = ModelPlayTrackDisplay(
            countTrack: countTrack ?? (0, 0),
            nameTrack: model.nameTrack,
            namePerformer: model.namePerformer,
            nameAlbum: model.nameAlbum,
            imageTrack: model.image)
        return model
    }
}
