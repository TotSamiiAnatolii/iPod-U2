//
//  PlayerBaseViewController.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 23.09.2023.
//

import UIKit

class PlayerBaseViewController<ContentView: UIView>: UIViewController {
    
    weak var parentControl: ContainerViewController?
        
    open var contentView: ContentView {
        guard let view = self.view as? ContentView else { return ContentView()}
        return view
    }
    
    override func loadView() {
        super.loadView()
        self.view = PlayerView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = true
        
        parentControl?.onAction = {[weak self] type in
            guard let self = self else {
                return
            }
            self.switchButton(sender: type)
        }
    }
    
    init(parentControl: ContainerViewController) {
        self.parentControl = parentControl
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func switchButton(sender: ButtonPlayer)  {
        
    }
}
