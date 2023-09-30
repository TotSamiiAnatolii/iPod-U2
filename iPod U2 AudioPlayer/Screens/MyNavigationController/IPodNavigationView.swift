//
//  IPodNavigationView.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 24.09.2023.
//

import UIKit

final class IPodNavigationView: UIView {

    private let innerShadow = CALayer()
    
    override func draw(_ rect: CGRect) {
        self.addInnerShadow(layer: innerShadow)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
