//
//  NavBarView.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import UIKit

final class NavBarView: UIView {
    
    private let hieghtBorder: CGFloat = 1
    
    private let indent: CGFloat = 10
    
    private let imageCurrentState = UIImageView()
        .setMyStyle()
        .setImage(image: Images.play)
    
    private let borderView = UIView()
        .setMyStyle(color: Colors.borderColor)
    
    private let header = UILabel()
        .setMyStyle(font: Fonts.heder)

    private let battary: UIImageView = UIImageView()
        .setMyStyle()
        .setImage(image: Images.battery)
    
    init() {
        super.init(frame: .zero)
        setupGradientView()
        setViewHierarhies()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    private func setupGradientView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        guard let gradientView = self.layer as? CAGradientLayer else {
            return;
        }
        gradientView.colors = [Colors.topColorNavBar, Colors.bottomColorNavBar]
        gradientView.locations = [0.0, 1.0]
        gradientView.frame = self.bounds
    }
    
    public func setStateCurrent(state: StatePlayer) {
        switch state {
        case .pause:
            self.imageCurrentState.image = Images.pause
        case .play:
            self.imageCurrentState.image = Images.play
        }
    }
    
    private func setViewHierarhies() {
        self.addSubview(imageCurrentState)
        self.addSubview(borderView)
        self.addSubview(header)
        self.addSubview(battary)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            borderView.widthAnchor.constraint(equalTo: self.widthAnchor),
            borderView.heightAnchor.constraint(equalToConstant: hieghtBorder),
            borderView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            header.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            header.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            battary.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.85),
            battary.widthAnchor.constraint(equalTo: battary.heightAnchor),
            battary.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -indent),
            battary.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageCurrentState.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            imageCurrentState.widthAnchor.constraint(equalTo: imageCurrentState.heightAnchor),
            imageCurrentState.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageCurrentState.leftAnchor.constraint(equalTo: self.leftAnchor, constant: indent)
        ])
    }
    
    public func setupNavigationBar(leftItem: UIImage?, header: String) {
        self.header.text = header
        self.imageCurrentState.image = leftItem
    }
}
