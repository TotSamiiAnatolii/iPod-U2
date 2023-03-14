//
//  UILabel+MyStyle.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import UIKit

extension UILabel {
    
    public func setMyStyle(font: UIFont) -> Self {
        self.numberOfLines = 1
        self.textAlignment = .left
        self.font = font
        self.textColor = .black
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    public func setLineBreakMode(lineBreak: NSLineBreakMode ) -> Self {
        self.lineBreakMode = lineBreak
        return self
    }
}
