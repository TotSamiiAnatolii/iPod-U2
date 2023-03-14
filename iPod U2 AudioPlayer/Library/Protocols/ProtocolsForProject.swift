//
//  ProtocolsForProject.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import Foundation

protocol ControlModuleDelegate: AnyObject {
    
    func onAction(sender: ButtonPlayer)
}

protocol ConfigurableView {
    associatedtype Model
    
    func configure(with model: Model)
}

protocol PlayerIPodDelegate: AnyObject {
    
    func goToBackTrack(name: String) -> ModelTrack?
    
    func forwardTrack(name: String) -> ModelTrack?
    
    func fetchContTrack(name: String) -> (Int, Int)
}
