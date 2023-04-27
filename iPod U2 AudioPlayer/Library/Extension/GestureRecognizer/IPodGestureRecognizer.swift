//
//  IPodGestureRecognizer.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import UIKit

let π = CGFloat.pi

final class IPodGestureRecognizer: UIGestureRecognizer {
    
    private var currentPoint: CGPoint?
    
    private var previousPoint: CGPoint?
    
    private var midPoint = CGPoint.zero
    
    private var innerRadius: CGFloat = 0
    
    private var outerRadius: CGFloat = 0
    
    public var rotation: CGFloat? {
        if let currentPoint = self.currentPoint {
            if let previousPoint = self.previousPoint {
                var rotation = angleBetween(pointA: currentPoint, andPointB: previousPoint)
                if (rotation > CGFloat(π)) {
                    
                    rotation -= CGFloat(π)*2
                }
                else if (rotation < -CGFloat(π)) {
                    
                    rotation += CGFloat(π)*2
                }
                
                return rotation
            }
        }
        
        return nil
    }
   
    private var distance: CGFloat? {
        if let nowPoint = self.currentPoint {
            return self.distanceBetween(pointA: self.midPoint, andPointB: nowPoint)
        }
        
        return nil
    }
    
    init(midPoint: CGPoint, innerRadius:CGFloat, outerRadius: CGFloat, target: AnyObject, action: Selector) {
        super.init(target: target, action: action)
        
        self.midPoint = midPoint
        self.innerRadius = innerRadius
        self.outerRadius = outerRadius
    }
    
    func distanceBetween(pointA: CGPoint, andPointB pointB: CGPoint) -> CGFloat {
        let dx = Float(pointA.x - pointB.x)
        let dy = Float(pointA.y - pointB.y)
        return CGFloat(sqrtf(dx*dx + dy*dy))
    }
    
    func angleForPoint(point: CGPoint) -> CGFloat {
        
        var angle = CGFloat(-atan2f(Float(point.x - midPoint.x), Float(point.y - midPoint.y))) + CGFloat(π)/2
        
        if (angle < 0) {
            angle += CGFloat(π)*2;
        }
        return angle
    }
    
    func angleBetween(pointA: CGPoint, andPointB pointB:CGPoint) -> CGFloat {
        return angleForPoint(point: pointA) - angleForPoint(point: pointB)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        if let firstTouch = touches.first {
            
            currentPoint = firstTouch.location(in: self.view)
            var newState:UIGestureRecognizer.State = .began
            
            if let distance = self.distance {
                if distance < innerRadius {
                    newState = .failed
                }
            }
            
            if let distance = self.distance {
                if distance > outerRadius {
                    newState = .failed
                }
            }
            state = newState
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        
        if state == .failed {
            return
        }
        
        if let firstTouch = touches.first {
            
            currentPoint = firstTouch.location(in: self.view)
            previousPoint = firstTouch.previousLocation(in: self.view)
            
            state = .changed
        }
        if let distance = self.distance {
            if distance < innerRadius {
                state = .failed
            }
        }
        
        if let distance = self.distance {
            if distance > outerRadius {
                state = .failed
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        state = .ended
        
        currentPoint = nil
        previousPoint = nil
    }
}

