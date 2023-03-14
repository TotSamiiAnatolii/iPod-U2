//
//  PlayerViewController.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import UIKit

final class PlayerViewController: UIViewController {
    
    weak var parentControl: ContainerViewController?
    
    private var model: ModelTrack
    
    weak var delegate: PlayerIPodDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    init(parentControl: ContainerViewController, model: ModelTrack) {
        self.parentControl = parentControl
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
