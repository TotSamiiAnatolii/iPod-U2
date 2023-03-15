//
//  SelectTrackCell.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import UIKit

final class SelectTrackCell: UITableViewCell {
    
    static let identifire = "SelectTrackCell"
    
    private let gradientLayer = CAGradientLayer()
    
    private let labelTrackName = UILabel()
        .setMyStyle(font: Fonts.general)
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.gradientLayer.isHidden = isSelected ? false : true
        labelTrackName.textColor = isSelected ? .white : .black
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = Colors.newDisplayColor
        setViewHierarhies()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.layer)
        gradientLayer.frame = self.bounds
        
        let colorSet = [Colors.progressMiddle, Colors.progressBottom]
        let location = [0.2, 1.0]
        
        self.contentView.addGradient(with: gradientLayer, colorSet: colorSet, locations: location)
    }
    
    private func setViewHierarhies() {
        contentView.addSubview(labelTrackName)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            labelTrackName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelTrackName.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10)
        ])
    }
}
extension SelectTrackCell: ConfigurableView {
    func configure(with model: ModelSelectTrackCell) {
        self.labelTrackName.text = model.trackName
    }
    
    typealias Model = ModelSelectTrackCell
}
