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
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private let titleView: ExploreTitleView = {
        let view = ExploreTitleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view 
    }()
    
    private let collectionView: ExploreCollectionView = {
        let view = ExploreCollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    // MARK: - INITIALIZERS
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        self.addSubview(contentView)
        contentView.addSubview(titleView)
        contentView.addSubview(collectionView)
        
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
            titleView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 2),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleView.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 2)
        ]
        
        let collectionViewConstraints = [
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            collectionView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 30),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(contentViewConstraints)
        NSLayoutConstraint.activate(titleViewConstraints)
        NSLayoutConstraint.activate(collectionViewConstraints)
    }
    
    // MARK: - FUNCTIONS
    func getTitleView() -> ExploreTitleView {
        return titleView
    }
    
    func getCollectionView() -> ExploreCollectionView {
        return collectionView
    }
}
