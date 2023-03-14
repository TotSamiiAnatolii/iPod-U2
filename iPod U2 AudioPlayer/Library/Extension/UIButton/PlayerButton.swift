//
//  PlayerButton.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import UIKit

struct ModelPlayerButtun {
    let image: UIImage?
    let title: String?
    let type: ButtonPlayer
    let font: UIFont?
    
    init(image: UIImage, type: ButtonPlayer) {
        self.image = image
        self.type = type
        self.title = nil
        self.font = nil
    }
    
    init(title: String, type: ButtonPlayer, font: UIFont) {
        self.image = nil
        self.type = type
        self.title = title
        self.font = font
    }
}

final class PlayerButton: UIButton {
    
    public var typeButton: ButtonPlayer?
    
    init(model: ModelPlayerButtun) {
        self.typeButton = model.type
        super.init(frame: .zero)
        self.clipsToBounds = true
        setConfiguration(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConfiguration(model: ModelPlayerButtun) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setImage(model.image, for: .normal)
        self.backgroundColor = .red
        self.setTitle(model.title, for: .normal)
        self.contentMode = .scaleAspectFill
        self.titleLabel?.font = model.font
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.gray.withAlphaComponent(0.7), for: .highlighted)
    }
}
