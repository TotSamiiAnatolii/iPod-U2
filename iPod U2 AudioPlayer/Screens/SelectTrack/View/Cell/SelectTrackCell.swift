//
//  SelectTrackCell.swift
//  iPod U2 AudioPlayer
//
//  Created by APPLE on 14.03.2023.
//

import UIKit

final class SelectTrackCell: UITableViewCell {
    
    static let identifire = "SelectTrackCell"
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.backgroundColor = Colors.displayColor
                labelName.textColor = .white
            } else {
                contentView.backgroundColor = Colors.newDisplayColor
                labelName.textColor = .black
            }
        }
    }

    private let labelName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.numbers
        return label
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            contentView.backgroundColor = Colors.displayColor
            labelName.textColor = .white
        } else {
            contentView.backgroundColor = Colors.newDisplayColor
            labelName.textColor = .black
        }
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
    
    private func setViewHierarhies() {
        contentView.addSubview(labelName)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            labelName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelName.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10)
        ])
    }
    
    public func configureCell(text: ModelTrack) {
        labelName.text = text.nameTrack
    }

}
