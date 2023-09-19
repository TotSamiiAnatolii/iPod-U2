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
    
    override func loadView() {
        super.loadView()
        self.view = ContainerView(frame: UIScreen.main.bounds)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
        containerView.controlModule.delegate = self
        showChildViewController()
    }

    private func showChildViewController() {
        let selectTrackVC = SelectTrackViewController(parentControl: self)
    
        let navSelectTrackVC = UINavigationController(rootViewController: selectTrackVC)
        
        self.addChild(navSelectTrackVC)
        
        navSelectTrackVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(navSelectTrackVC.view)
        
        NSLayoutConstraint.activate([
            navSelectTrackVC.view.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            navSelectTrackVC.view.heightAnchor.constraint(equalToConstant: 300),
            navSelectTrackVC.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            navSelectTrackVC.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        ])
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


