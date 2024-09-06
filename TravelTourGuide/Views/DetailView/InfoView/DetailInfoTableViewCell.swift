//
//  DetailInfoTableViewCell.swift
//  TravelTourGuide
//
//  Created by 권정근 on 9/7/24.
//

import UIKit

class DetailInfoTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    static let identifier = "DetailInfoTableViewCell"
    
    // MARK: - UI Components
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "phone.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1010-1010"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(iconImageView)
        contentView.addSubview(infoLabel)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layouts
    private func configureConstraints() {
        let iconImageViewConstraints = [
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        let infoLabelConstraints = [
            infoLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            infoLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(iconImageViewConstraints)
        NSLayoutConstraint.activate(infoLabelConstraints)
    }
    
    
    // MARK: - Functions
    func configure(title: String, value: String) {
        iconImageView.image = UIImage(systemName: title)
        infoLabel.text = value
    }
}
