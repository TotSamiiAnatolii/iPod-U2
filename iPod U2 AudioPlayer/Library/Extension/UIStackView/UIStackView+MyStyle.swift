//
//  UIStackView+MyStyle.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import UIKit

extension UIStackView {
   
    public func myStyleStack(spacing: CGFloat, aligment: UIStackView.Alignment, axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution, userInteraction: Bool) -> Self {
        self.axis = axis
        self.distribution = distribution
        self.alignment = aligment
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = userInteraction
        return self
    }
}
