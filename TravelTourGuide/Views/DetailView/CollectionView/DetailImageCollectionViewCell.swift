//
//  DetailImageCollectionViewCell.swift
//  TravelTourGuide
//
//  Created by 권정근 on 9/6/24.
//

import UIKit

class DetailImageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Variables
    static let identifier = "DetailImageCollectionViewCell"
    
    
    // MARK: - UI Components
    private let detailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(detailImageView)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layouts
    private func configureConstraints() {
        
        let detailImageViewConstraints = [
            detailImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailImageView.topAnchor.constraint(equalTo: topAnchor),
            detailImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(detailImageViewConstraints)
    }
    
    // MARK: - Functions
    func configure(with originimgurl: String) {
        
        let secureOriginImgURL = originimgurl.replacingOccurrences(of: "http://", with: "https://")
        
        if let url = URL(string: secureOriginImgURL) {
            detailImageView.sd_setImage(with: url)
        } else {
            detailImageView.image = UIImage(systemName: "house")
        }
    }
}
