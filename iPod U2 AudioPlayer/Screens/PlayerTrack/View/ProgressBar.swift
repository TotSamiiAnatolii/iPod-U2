//
//  ProgressBar.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import UIKit

final class ProgressBar: UIView {
    
    private let shapeLayer = CAShapeLayer()
    
    private let progressGradient = CAGradientLayer()
    
    private let progressLayer = CALayer()
    
    private let gradientLocations: [NSNumber] = [0.1, 0.2, 0.5, 0.7]
    
    private var progress: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setViewHierarhies()
        setupBackgroundView()
        setupProgressView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func draw(_ rect: CGRect) {
        createProgressLayer(rect: rect)
        drawDottedLine(view: progressLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setShadow()
    }
    
    private func setViewHierarhies() {
        self.layer.addSublayer(progressLayer)
        progressLayer.addSublayer(shapeLayer)
        progressLayer.insertSublayer(progressGradient, at: 0)
    }
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = false
    }
    
    private func createProgressLayer(rect: CGRect) {
        let progressRect = CGRect(origin: .zero, size: CGSize(width: rect.width * progress, height: rect.height))
        progressLayer.frame = progressRect
        progressGradient.frame = progressRect
    }
    
    public func convertValue(value: CGFloat) {
        progress = value / 100
    }
    
    private func setupBackgroundView() {
        
        guard let backGradient = self.layer as? CAGradientLayer else {
            return
        }
        backGradient.colors = [Colors.backTop, Colors.backWhite, Colors.backMiddle, Colors.backBottom]
        backGradient.locations = gradientLocations
        backGradient.frame = self.bounds
    }
    
    private func setupProgressView() {
        progressGradient.colors = [Colors.progreesTop, Colors.progressWhite, Colors.progressMiddle, Colors.progressBottom]
        progressGradient.locations = gradientLocations
    }
    
    private func setShadow() {
        let radius = self.layer.cornerRadius
        self.layer.shadowColor = #colorLiteral(red: 0.5796210972, green: 0.5796210972, blue: 0.5796210972, alpha: 1).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 8
        self.layer.shadowRadius = 2
        self.layer.cornerRadius = radius
    }
    
    private func drawDottedLine(view: CALayer) {
        let path = CGMutablePath()
      
        let lengthFactor: CGFloat = 1.8
        
        let heightDottedLine = view.bounds.height
        
        let startPoint = CGPoint(x: view.frame.minX, y: view.frame.midY)
        
        let endPoint = CGPoint(x: view.frame.midX * lengthFactor, y: view.frame.midY)
        
        shapeLayer.strokeColor = UIColor.black.withAlphaComponent(0.04).cgColor
        shapeLayer.lineWidth = heightDottedLine
        shapeLayer.lineDashPattern = [7, 10]
        shapeLayer.fillRule = .evenOdd
        path.addLines(between: [startPoint, endPoint])
        shapeLayer.path = path
    }
}

