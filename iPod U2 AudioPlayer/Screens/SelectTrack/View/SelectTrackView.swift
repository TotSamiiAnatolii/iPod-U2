//
//  SelectTrackView.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import UIKit

final class SelectTrackView: UIView {
   
    private let innerShadow = CALayer()
          
    private let borderWidth: CGFloat = 0.7
        
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
        self.addSubview(tableView)
        self.layer.addSublayer(innerShadow)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.isUserInteractionEnabled = false
        tableView.backgroundColor = Colors.newDisplayColor
        tableView.register(SelectTrackCell.self, forCellReuseIdentifier: SelectTrackCell.identifire)
    }
}
