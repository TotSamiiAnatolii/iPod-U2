//
//  SelectTrackView.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import UIKit

final class SelectTrackView: UIView {
    
    private let radius: CGFloat = 0
    
    private let innerShadow = CALayer()
  
    private let stateView = NavBarView(header: "Songs")
        
    private let borderWidth: CGFloat = 0.7
    
    private let borderColor = Colors.borderDisplayColor
    
    public var tableView: UITableView!
    
    private func setupView() {
        self.backgroundColor = Colors.newDisplayColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
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
        addInnerShadow()
    }
    
    private func setViewHierarhies() {
        self.addSubview(stateView)
        self.addSubview(tableView)
        self.layer.addSublayer(innerShadow)
    }
    
    private func setupConstraints() {

        NSLayoutConstraint.activate([
            stateView.widthAnchor.constraint(equalTo: self.widthAnchor),
            stateView.heightAnchor.constraint(equalToConstant: 35),
            stateView.topAnchor.constraint(equalTo: self.topAnchor)
        ])

        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: stateView.bottomAnchor)
        ])
    }
    
    private func configureTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = Colors.newDisplayColor
        tableView.register(SelectTrackCell.self, forCellReuseIdentifier: SelectTrackCell.identifire)
    }
    
    private func addInnerShadow() {
        innerShadow.frame = self.bounds
        let radius = self.layer.cornerRadius
        
        let path = UIBezierPath(roundedRect: innerShadow.bounds.insetBy(dx: 2, dy: 2), cornerRadius: radius)
        
        let cutout = UIBezierPath(roundedRect: innerShadow.bounds, cornerRadius: radius).reversing()
        
        path.append(cutout)
        innerShadow.shadowPath = path.cgPath
        
        innerShadow.masksToBounds = true
        
        innerShadow.shadowColor = Colors.shadowDisplayColor
        innerShadow.shadowOffset = CGSize(width: 0, height: 3)
        innerShadow.shadowOpacity = 5
        innerShadow.shadowRadius = 3
        innerShadow.cornerRadius = radius
    }
}
