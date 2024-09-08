//
//  PlaceCategoryCollectionViewCell.swift
//  TravelTourGuide
//
//  Created by 권정근 on 9/9/24.
//

import UIKit

class PlaceCategoryCollectionViewCell: UICollectionViewCell {

    
    // MARK: - VARIABLES
    static let identifier = "PlaceCategoryCollectionViewCell"
    
    // MARK: - UI COMPONETS
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Hakgyoansim Chulseokbu TTF B", size: 18)
        label.textAlignment = .left
        label.textColor = .label
        return label
    }()
    
    private let underLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemRed
        view.isHidden = true
        return view
    }()
    
    
    // MARK: - INITIALIZERS
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(underLine)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LAYOUTS
    private func configureConstraints() {
        let titleLabelConstraint = [
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        let underLineConstraints = [
            underLine.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            underLine.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 4),
            underLine.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -4),
            underLine.heightAnchor.constraint(equalToConstant: 2)
        ]
        
        NSLayoutConstraint.activate(titleLabelConstraint)
        NSLayoutConstraint.activate(underLineConstraints)
    }
    
    
    // MARK: - FUNCTIONS
    func configureCategory(title: String, isSelected: Bool) {
        titleLabel.text = title
        underLine.isHidden = !isSelected
        if isSelected == true {
            titleLabel.textColor = .systemRed
   
        } else {
            titleLabel.textColor = .label
        }
    }
}
