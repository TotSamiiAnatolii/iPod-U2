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
        if !self.stateShadow {
            addDropShadow()
            addInnerShadow2()
            self.stateShadow = true
        }
    }
    
    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//        addInnerShadow2()
    }
    
    private func configureButton() {
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = #colorLiteral(red: 0.008659288588, green: 0.008885328063, blue: 0.008557020373, alpha: 1)
        self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        self.layer.borderWidth = 0.7
        self.layer.insertSublayer(innerShadow2, at: 0)
    }
    
    private func addInnerShadow2() {
        let radius = self.layer.cornerRadius

        innerShadow2.backgroundColor = self.backgroundColor?.cgColor
        innerShadow2.frame = self.bounds
        
        let path = UIBezierPath(roundedRect: innerShadow2.bounds.insetBy(dx: 4, dy: 4), cornerRadius: radius)
        
        let cutout = UIBezierPath(roundedRect: innerShadow2.bounds, cornerRadius: radius).reversing()
        
        path.append(cutout)
        
        innerShadow2.shadowPath = path.cgPath
//        innerShadow2.masksToBounds = true
//        innerShadow2.shadowColor = #colorLiteral(red: 0.1919550827, green: 0.2076032088, blue: 0.2276407525, alpha: 1).cgColor
        innerShadow2.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        innerShadow2.shadowOffset = CGSize(width: -4, height: 1)
        innerShadow2.shadowOpacity = 4
        innerShadow2.shadowRadius = 3
        innerShadow2.cornerRadius = radius
    }
    
    private func createShadowLayer(color: UIColor, offset: CGSize, opacity: Float, radius: CGFloat) -> CAShapeLayer {
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.frame.height / 2).cgPath
        shadowLayer.fillColor = self.backgroundColor?.cgColor
        shadowLayer.masksToBounds = false
        shadowLayer.shadowColor = color.cgColor
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowOffset = offset
        shadowLayer.shadowRadius = radius
        return shadowLayer
    }
    
    private func addDropShadow() {
//        let topLayer = createShadowLayer(
//            color: Colors.topShadow,
//            offset: CGSize(width: -2, height: -2),
//            opacity: 15,
//            radius: 4)
//        topLayer.name = ShadowType.topShadow.rawValue
        
        let bottomLayer = createShadowLayer(
            color: Colors.shadowKeyBoardButtonColor,
            offset: CGSize(width: 0, height: 0),
            opacity: 6,
            radius: 3)
//        bottomLayer.name = ShadowType.bottomShadow.rawValue
        
//        centerView.layer.insertSublayer(topLayer, at: 0)
        self.layer.insertSublayer(bottomLayer, at: 0)
    }
}

