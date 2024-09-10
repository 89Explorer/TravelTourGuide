//
//  ExploreContentView.swift
//  TravelTourGuide
//
//  Created by 권정근 on 9/9/24.
//

import UIKit

class ExploreContentView: UIView {
    
    // MARK: - UI COMPONENTS
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let titleView: ExploreTitleView = {
        let view = ExploreTitleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let collectionView: ExploreCollectionView = {
        let view = ExploreCollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let restaurantCollectionView: ExploreCollectionView = {
        let collectionView = ExploreCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let accommodationCollectionView: ExploreCollectionView = {
        let collectionView = ExploreCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    

    // MARK: - INITIALIZERS
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        self.addSubview(contentView)
        contentView.addSubview(titleView)
        contentView.addSubview(collectionView)
        contentView.addSubview(restaurantCollectionView)
        contentView.addSubview(accommodationCollectionView)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LAYOUTS
    private func configureConstraints() {
        
        let contentViewConstraints = [
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        
        let titleViewConstraints = [
            titleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16)
        ]
        
        let collectionViewConstraints = [
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            collectionView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 30)
        ]
        
        
        let restaurantCollectionViewConstraints = [
            restaurantCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            restaurantCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            restaurantCollectionView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 40)
        ]
        
        let accommodationCollectionViewConstraints = [
            accommodationCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            accommodationCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            accommodationCollectionView.topAnchor.constraint(equalTo: restaurantCollectionView.bottomAnchor, constant: 40),
            accommodationCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ]
            
        
        NSLayoutConstraint.activate(contentViewConstraints)
        NSLayoutConstraint.activate(titleViewConstraints)
        NSLayoutConstraint.activate(collectionViewConstraints)
        NSLayoutConstraint.activate(restaurantCollectionViewConstraints)
        NSLayoutConstraint.activate(accommodationCollectionViewConstraints)
    }
    
    // MARK: - FUNCTIONS
    
    func getTitleView() -> ExploreTitleView {
        return titleView
    }
    
    
    func getCollectionView() -> ExploreCollectionView {
        return collectionView
    }
    
    func getRestaurantCollectionView() -> ExploreCollectionView {
        return restaurantCollectionView
    }
    
    func getaccommodationCollectionView() -> ExploreCollectionView {
        return accommodationCollectionView
    }
}
