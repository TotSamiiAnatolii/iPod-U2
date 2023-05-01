//
//  SelectTrackView.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import UIKit

final class SelectTrackView: UIView {
   
    private let innerShadow = CALayer()
  
    private let navBarView = NavBarView(header: "Songs")
        
    private let borderWidth: CGFloat = 0.7
    
    private let heightNavBarView: CGFloat = 35
    
    private let borderColor = Colors.borderDisplayColor
    
    public var tableView: UITableView!
    
    private func setupView() {
        self.backgroundColor = Colors.newDisplayColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configureTableView()
        setViewHierarhies()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        self.addInnerShadow(layer: innerShadow)
    }
    
    private func setViewHierarhies() {
        self.addSubview(navBarView)
        self.addSubview(tableView)
        self.layer.addSublayer(innerShadow)
    }
    
    private func setupConstraints() {

        NSLayoutConstraint.activate([
            navBarView.widthAnchor.constraint(equalTo: self.widthAnchor),
            navBarView.heightAnchor.constraint(equalToConstant: heightNavBarView),
            navBarView.topAnchor.constraint(equalTo: self.topAnchor)
        ])

        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: navBarView.bottomAnchor)
        ])
    }
    
    private func configureTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.isUserInteractionEnabled = false
        tableView.backgroundColor = Colors.newDisplayColor
        tableView.register(SelectTrackCell.self, forCellReuseIdentifier: SelectTrackCell.identifire)
    }
}
