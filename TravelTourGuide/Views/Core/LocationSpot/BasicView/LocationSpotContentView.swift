//
//  LocationSpotContentView.swift
//  TravelTourGuide
//
//  Created by 권정근 on 9/11/24.
//

import UIKit

class LocationSpotContentView: UIView {
    
    // MARK: - UI Components
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view 
    }()
    
    private let locationSpotTitleView: LocationSpotTitleView = {
        let view = LocationSpotTitleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - INITIALIZERS
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubview(contentView)
        contentView.addSubview(locationSpotTitleView)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - LAYOUTS
    private func configureConstraints() {
        let contentViewConstraints = [
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        let locationSpotTitleViewConstraints = [
            locationSpotTitleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            locationSpotTitleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            locationSpotTitleView.topAnchor.constraint(equalTo: contentView.topAnchor)
            
        ]
        NSLayoutConstraint.activate(contentViewConstraints)
        NSLayoutConstraint.activate(locationSpotTitleViewConstraints)
    }
    
    // MARK: - FUNCTIONS
    func getlocationSpotTitleView() -> LocationSpotTitleView {
        return locationSpotTitleView
    }
}
