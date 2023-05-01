//
//  UIIMageView+MyStyle.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import UIKit

extension UIImageView {

    public func setMyStyle() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
        return self
    }
    
    public func setImage(image: UIImage?) -> Self {
        self.image = image
        return self
    }
}
