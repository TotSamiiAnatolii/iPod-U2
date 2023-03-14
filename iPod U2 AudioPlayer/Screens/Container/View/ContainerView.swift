//
//  ContainerView.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import UIKit

final class ContainerView: UIView {
    
    let display: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public var onAction: ((ButtonPlayer) -> Void)?
    
    public let controlModule = ControlModule(frame: .zero)

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
        self.addSubview(display)
        self.addSubview(controlModule)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            display.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            display.heightAnchor.constraint(equalToConstant: 300),
            display.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            display.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
           
            controlModule.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75),
            controlModule.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75),
            controlModule.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            controlModule.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100)
        ])
    }


}
