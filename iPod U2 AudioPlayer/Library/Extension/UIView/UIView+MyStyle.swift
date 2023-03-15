//
//  UIView+MyStyle.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 15.03.2023.
//

import UIKit

extension UIView {
    
    func setMyStyle(color: UIColor) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = color
        return self
    }
}
