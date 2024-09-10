//
//  LoadMoreCollectionViewCell.swift
//  TravelTourGuide
//
//  Created by 권정근 on 9/11/24.
//

import UIKit

class LoadMoreCollectionViewCell: UICollectionViewCell {
    
    // MARK: - VARIABLES
    static let identifier = "LoadMoreCollectionViewCell"
    
    // MARK: - UI COMPONENTS
    private let loadMoreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("더 보기 ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    
    // MARK: - INITIALIZERS
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(loadMoreButton)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LAYOUTS
    private func configureConstraints() {
        let loadMoreButtonConstraints = [
            loadMoreButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            loadMoreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            loadMoreButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            loadMoreButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(loadMoreButtonConstraints)
    }
    
    func getloadMoreButton() -> UIButton {
        return loadMoreButton
    }
}
