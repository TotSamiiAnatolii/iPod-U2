//
//  ViewController.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import UIKit

final class ContainerViewController: UIViewController {

    public var onAction: ((ButtonPlayer) -> Void)?
    
    fileprivate var containerView: ContainerView {
        guard let view = self.view as? ContainerView else {
            return ContainerView()
        }
        return view
    }
    
    private lazy var navVC: UINavigationController = {
        prepareChildViewController()
    }()
    
    override func loadView() {
        super.loadView()
        self.view = ContainerView(frame: UIScreen.main.bounds)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
        containerView.controlModule.delegate = self
        self.addChild(navVC)
    }

    private func prepareChildViewController() -> UINavigationController {
        let selectTrackVC = SelectTrackViewController(parentControl: self)
    
        let navigationController = IPodNavigationController(rootViewController: selectTrackVC)
                
        navigationController.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(navigationController.view)
        
        NSLayoutConstraint.activate([
            navigationController.view.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            navigationController.view.heightAnchor.constraint(equalToConstant: 300),
            navigationController.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            navigationController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        ])
        
        return navigationController
    }

    private func switchButton(sender: ButtonPlayer)  {
        onAction?(sender)
    }
}
extension ContainerViewController: ControlModuleDelegate {
    
    func controlModuleAction(sender: ButtonPlayer) {
        switchButton(sender: sender)
    }
}


