//
//  SelectButton.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import UIKit

final class SelectButton: UIButton {
    
    public var typeButton: ButtonPlayer?
    
    private var stateShadow = false
    
    private var innerShadow = CALayer()
    
    private var innerShadow2 = CALayer()
    
    init(type: ButtonPlayer) {
        self.typeButton = type
        super.init(frame: .zero)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
    }
 
    private func configureButton() {
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = #colorLiteral(red: 0.008659288588, green: 0.008885328063, blue: 0.008557020373, alpha: 1)
        self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        self.layer.borderWidth = 0.7
        self.layer.insertSublayer(innerShadow2, at: 0)
    }
}

