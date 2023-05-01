//
//  ContainerView.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import UIKit

final class ContainerView: UIView {
 
    var onAction: ((ButtonPlayer) -> Void)?
    
    let controlModule = ControlModule(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .black
        setViewHierarhies()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarhies() {
        self.addSubview(controlModule)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            controlModule.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75),
            controlModule.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75),
            controlModule.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            controlModule.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100)
        ])
    }
}
