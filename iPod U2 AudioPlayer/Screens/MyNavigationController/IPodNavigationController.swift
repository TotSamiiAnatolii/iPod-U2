//
//  IPodNavigationController.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 23.09.2023.
//

import UIKit

class IPodNavigationController: UINavigationController {
    
    private let navBarView = NavBarView(header: "Songs")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 35)
        additionalSafeAreaInsets = UIEdgeInsets(top: 35, left: 0, bottom: 0, right: 0)
        prepareView()
        setViewHierarhies()
        setupConstraints()
    }
    
    private func prepareView() {
        navigationBar.isHidden = true
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            navBarView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            navBarView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            navBarView.topAnchor.constraint(equalTo: self.view.topAnchor),
            navBarView.heightAnchor.constraint(equalToConstant: navigationBar.frame.height)
        ])
    }
    
    private func setViewHierarhies() {
        self.view.addSubview(navBarView)
    }
}
