//
//  CategoryCollectionView.swift
//  TravelTourGuide
//
//  Created by 권정근 on 9/3/24.
//

import UIKit

class CategoryCollectionView: UIView {
    
    // MARK: - UI Components
    private let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        // layout.minimumLineSpacing = 10
        //layout.minimumInteritemSpacing = 10 // 셀 간 간격 설정
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(categoryCollectionView)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: Layouts
    private func configureConstraints() {
        let categoryCollectionViewConstraints = [
            categoryCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoryCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            categoryCollectionView.topAnchor.constraint(equalTo: topAnchor),
            categoryCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(categoryCollectionViewConstraints)
    }
    
    
    // MARK: - Functions
    func getcategoryCollectionView() -> UICollectionView {
        return categoryCollectionView
    }
}
