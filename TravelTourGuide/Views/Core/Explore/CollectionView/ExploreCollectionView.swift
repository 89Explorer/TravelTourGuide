//
//  ExploreCollectionView.swift
//  TravelTourGuide
//
//  Created by 권정근 on 9/9/24.
//

import UIKit

class ExploreCollectionView: UIView {
    
    // MARK: - UI COMPONENTS
    private let placeCategoryCollectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 35
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let placeIntroduceCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: 240, height: 200)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
        
    }()
    
    // MARK: - INITIALIZERS
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        self.addSubview(placeCategoryCollectionview)
        self.addSubview(placeIntroduceCollectionView)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - LAYOUTS
    private func configureConstraints() {
        let placeCategoryCollectionviewConstraints = [
            placeCategoryCollectionview.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            placeCategoryCollectionview.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            placeCategoryCollectionview.topAnchor.constraint(equalTo: self.topAnchor),
            placeCategoryCollectionview.heightAnchor.constraint(equalToConstant: 24)
        ]
        
        let placeIntroduceCollectionViewConstraints = [
            placeIntroduceCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            placeIntroduceCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            placeIntroduceCollectionView.topAnchor.constraint(equalTo: placeCategoryCollectionview.bottomAnchor, constant: 30),
            placeIntroduceCollectionView.heightAnchor.constraint(equalToConstant: 200),
            placeIntroduceCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
                                                                  
        ]
        NSLayoutConstraint.activate(placeCategoryCollectionviewConstraints)
        NSLayoutConstraint.activate(placeIntroduceCollectionViewConstraints)
    }
    
    // MARK: - FUNCTIONS
    func getCategoryCollectionview() -> UICollectionView {
        return placeCategoryCollectionview
    }
    
    func getIntroduceCollectionview() -> UICollectionView {
        return placeIntroduceCollectionView
    }
}
