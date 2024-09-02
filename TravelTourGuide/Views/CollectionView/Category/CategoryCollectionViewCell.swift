//
//  CategoryCollectionViewCell.swift
//  TravelTourGuide
//
//  Created by 권정근 on 9/3/24.
//


import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Variables
    static let identifier = "CategoryCollectionViewCell"
    
    
    // MARK: - UI Components
    private let imageTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center // 텍스트와 이미지 중앙 정렬
        stackView.spacing = 2
        return stackView
    }()
    
    
    private let categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "attractions")
        imageView.layer.cornerRadius = 40
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    private let categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .black)
        label.text = "관광지"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageTitleStackView)
        imageTitleStackView.addArrangedSubview(categoryImageView)
        imageTitleStackView.addArrangedSubview(categoryTitleLabel)
        
        configureConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Layouts
    private func configureConstraints() {
        let imageTitleStackViewConstraints = [
            imageTitleStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageTitleStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageTitleStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageTitleStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        let categoryImageViewConstraints = [
            categoryImageView.widthAnchor.constraint(equalToConstant: 80),
            categoryImageView.heightAnchor.constraint(equalToConstant: 80)
        ]
        
        NSLayoutConstraint.activate(imageTitleStackViewConstraints)
        NSLayoutConstraint.activate(categoryImageViewConstraints)
    }
    
    // MARK: - Functions
    func configureCategory(with image: String, title: String) {
        categoryImageView.image = UIImage(named: image)
        categoryTitleLabel.text = title
    }
}
