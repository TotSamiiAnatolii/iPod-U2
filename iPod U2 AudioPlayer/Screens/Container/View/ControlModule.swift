//
//  ControlModule.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import UIKit

final class ControlModule: UIView {
    
    weak var delegate: ControlModuleDelegate?
    
    private var corner: CGFloat = 0.0
    
    private let indent: CGFloat = 10
    
    private let mainView = UIView()
        .setMyStyle(color: Colors.controlModule)
    
    private let selectionRing = UIView()
        .setMyStyle(color: Colors.controlModule)
    
    private lazy var selectButton = SelectButton(type: .select)
        .setTarget(method: #selector(buttonAction), target: self, event: .touchUpInside)
    
    private lazy var menuButton = PlayerButton(model: ModelPlayerButtun(
        title: ButtonPlayer.menu.rawValue,
        type: ButtonPlayer.menu,
        font: Fonts.menu))
        .setTarget(method: #selector(buttonAction), target: self, event: .touchUpInside)
    
    private lazy var pausePlayButton = PlayerButton(model: ModelPlayerButtun(
        image: Images.playPause,
        type: ButtonPlayer.playPause))
        .setTarget(method: #selector(buttonAction), target: self, event: .touchUpInside)
    
    private lazy var leftButton = PlayerButton(model: ModelPlayerButtun(
        image: Images.left,
        type: ButtonPlayer.left))
        .setTarget(method: #selector(buttonAction), target: self, event: .touchUpInside)
    
    private lazy var rightButton = PlayerButton(model: ModelPlayerButtun(
        image: Images.right,
        type: ButtonPlayer.right))
        .setTarget(method: #selector(buttonAction), target: self, event: .touchUpInside)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setViewHierarhies()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainView.layer.cornerRadius = mainView.frame.height / 2
        selectionRing.layer.cornerRadius = self.selectionRing.frame.height / 2
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        addGesture(view: mainView, target: self)
    }
    
    private func setViewHierarhies() {
        self.addSubview(selectionRing)
        self.addSubview(mainView)
        self.addSubview(selectButton)
        self.addSubview(menuButton)
        self.addSubview(pausePlayButton)
        self.addSubview(leftButton)
        self.addSubview(rightButton)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.leftAnchor.constraint(equalTo: self.leftAnchor),
            mainView.rightAnchor.constraint(equalTo: self.rightAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            selectionRing.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.7),
            selectionRing.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.7),
            selectionRing.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            selectionRing.centerYAnchor.constraint(equalTo: mainView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            selectButton.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.35),
            selectButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.35),
            selectButton.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            selectButton.centerYAnchor.constraint(equalTo: mainView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            menuButton.topAnchor.constraint(equalTo: mainView.topAnchor, constant: indent),
            menuButton.bottomAnchor.constraint(equalTo: selectionRing.topAnchor),
            menuButton.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            pausePlayButton.topAnchor.constraint(equalTo: selectionRing.bottomAnchor),
            pausePlayButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -indent),
            pausePlayButton.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            leftButton.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: indent),
            leftButton.rightAnchor.constraint(equalTo: selectionRing.leftAnchor),
            leftButton.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            rightButton.leftAnchor.constraint(equalTo: selectionRing.rightAnchor),
            rightButton.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -indent),
            rightButton.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
        ])
    }
    
    private func addGesture(view: UIView, target: UIView) {
        let innerRadius = selectButton.frame.height / 2
        
        let outerRadius = selectionRing.frame.height
        
        view.addGestureRecognizer(IPodGestureRecognizer(midPoint: mainView.center, innerRadius: innerRadius, outerRadius: outerRadius, target: target, action: #selector(rotateGesture(recognizer:))))
    }
    
    @objc func buttonAction(sender: PlayerButton) {
        guard let type = sender.typeButton else { return }
        delegate?.onAction(sender: type)
    }
    
    @objc func rotateGesture(recognizer: IPodGestureRecognizer) {
        let maxValue: CGFloat = 10
        let minValue: CGFloat = -1
        
        if let rotation = recognizer.rotation {
            
            corner += (rotation.degrees / 360) * 100
            if corner > maxValue {
                delegate?.onAction(sender: .forward)
                corner = 0
            }
            if corner < minValue {
                delegate?.onAction(sender: .back)
                corner = maxValue
            }
        }
    }
}
