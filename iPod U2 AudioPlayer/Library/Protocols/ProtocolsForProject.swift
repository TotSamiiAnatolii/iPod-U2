//
//  ProtocolsForProject.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import Foundation

protocol ControlModuleDelegate: AnyObject {
    
    func controlModuleAction(sender: ButtonPlayer)
}

protocol ConfigurableView {
    associatedtype Model
    
    func configure(with model: Model)
}

protocol PlayerIPodDelegate: AnyObject {
    
    func goToBackTrack(id: UUID) -> ModelTrack?
    
    func forwardTrack(id: UUID) -> ModelTrack?
    
    func fetchCountTrack(id: UUID) -> (Int, Int)
}
