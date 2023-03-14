//
//  UIButton+Target.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import UIKit

extension UIButton {
    
    public func setTarget(method methodDown: Selector, target: Any, event: UIControl.Event ) -> Self {

        self.addTarget(target, action: methodDown.self, for: event)
        
        return self
    }
}
