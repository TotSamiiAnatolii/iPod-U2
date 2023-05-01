//
//  UIView+Gradient.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import UIKit

extension UIView {
    
    func addGradient(with layer: CAGradientLayer, colorSet: [CGColor],
                     locations: [Double]) {
        layer.frame.origin = .zero
        let layerLocations = locations.map { $0 as NSNumber }
        layer.colors = colorSet
        layer.locations = layerLocations
        self.layer.insertSublayer(layer, at: 0)
    }
}
