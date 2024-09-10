//
//  LocationSpotScrollView.swift
//  TravelTourGuide
//
//  Created by 권정근 on 9/10/24.
//

import UIKit

class LocationSpotScrollView: UIView {
    
    // MARK: - UI COMPONENTS
    private let basicScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let locationContentView: LocationSpotContentView = {
        let view = LocationSpotContentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - INITIALIZERS
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubview(basicScrollView)
        basicScrollView.addSubview(locationContentView)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LAYOUTS
    private func configureConstraints() {
        let basicScrollViewConstraints = [
            basicScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            basicScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            basicScrollView.topAnchor.constraint(equalTo: topAnchor),
            basicScrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        let LocationSpotContentViewConstraints = [
            locationContentView.leadingAnchor.constraint(equalTo: basicScrollView.leadingAnchor),
            locationContentView.trailingAnchor.constraint(equalTo: basicScrollView.trailingAnchor),
            locationContentView.topAnchor.constraint(equalTo: basicScrollView.topAnchor),
            locationContentView.bottomAnchor.constraint(equalTo: basicScrollView.bottomAnchor, constant: -80),
            locationContentView.widthAnchor.constraint(equalTo: basicScrollView.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(basicScrollViewConstraints)
        NSLayoutConstraint.activate(LocationSpotContentViewConstraints)
    }
    
    // MARK: - FUNCTIONS
    func configureSetTitle(mainTitle: String, subTitle: String) {
        locationContentView.getlocationSpotTitleView().configureTitle(main: mainTitle, sub: subTitle)
    }
    
    func getlocationView() -> LocationSpotContentView {
        return locationContentView
    }
}
