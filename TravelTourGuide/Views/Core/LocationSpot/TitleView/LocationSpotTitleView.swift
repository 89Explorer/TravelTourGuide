//
//  LocationSpotTitleView.swift
//  TravelTourGuide
//
//  Created by 권정근 on 9/10/24.
//

import UIKit

class LocationSpotTitleView: UIView {

    // MARK: - UI COMPONENTS
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .fill
        return stackView
    }()
    
    private let mainTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Hakgyoansim Chulseokbu TTF B", size: 24)
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let subTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Hakgyoansim Chulseokbu TTF B", size: 16)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - INITIALIZERS
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        self.addSubview(titleStackView)
        titleStackView.addArrangedSubview(mainTitle)
        titleStackView.addArrangedSubview(subTitle)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LAYOUTS
    private func configureConstraints() {
        
        let titleStackViewConstraints = [
            titleStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleStackView.topAnchor.constraint(equalTo: topAnchor),
            titleStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(titleStackViewConstraints)
    }
    
    // MARK: - FUNCTIONS
    func configureTitle(main: String, sub: String) {
        mainTitle.text = main
        subTitle.text = sub
    }
}
