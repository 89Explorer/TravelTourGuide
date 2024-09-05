//
//  DetailHeaderView.swift
//  TravelTourGuide
//
//  Created by 권정근 on 9/4/24.
//

import UIKit

class DetailHeaderView: UIView {
    
    // MARK: - UI Components
    private let detailImageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemRed
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let detailTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "전주 한옥 마을"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private let detailAddressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "인천특별시 강화군 하곡동 220-2번지"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(detailImageCollectionView)
        addSubview(detailTitleLabel)
        addSubview(detailAddressLabel)
        
        configureContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Layouts
    private func configureContraints() {
        
        let detailImageCollectionViewConstraints = [
            detailImageCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailImageCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailImageCollectionView.topAnchor.constraint(equalTo: topAnchor),
            detailImageCollectionView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let detailTitleLabelConstraints = [
            detailTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            detailTitleLabel.topAnchor.constraint(equalTo: detailImageCollectionView.bottomAnchor, constant: 15),
            detailTitleLabel.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        let detailAddressLabelConstraints = [
            detailAddressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            detailAddressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            detailAddressLabel.topAnchor.constraint(equalTo: detailTitleLabel.bottomAnchor, constant: 0),
            detailAddressLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ]
        
        NSLayoutConstraint.activate(detailImageCollectionViewConstraints)
        NSLayoutConstraint.activate(detailTitleLabelConstraints)
        NSLayoutConstraint.activate(detailAddressLabelConstraints)
    }
    
    
    // MARK: - Functions
    func configureDetailCollectionView() -> UICollectionView {
        return detailImageCollectionView
    }
}
