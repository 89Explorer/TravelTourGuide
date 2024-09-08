//
//  ExploreBasicScrollView.swift
//  TravelTourGuide
//
//  Created by 권정근 on 9/9/24.
//

import UIKit

class ExploreBasicScrollView: UIView {
    
    // MARK: - UI COMPONENTS
    private let basicScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: ExploreContentView = {
        let view = ExploreContentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - INITIALIZERS
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        self.addSubview(basicScrollView)
        basicScrollView.addSubview(contentView)
        
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
        
        let contentViewConstraints = [
            contentView.leadingAnchor.constraint(equalTo: basicScrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: basicScrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: basicScrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: basicScrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: basicScrollView.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(basicScrollViewConstraints)
        NSLayoutConstraint.activate(contentViewConstraints)
    }
    
    // MARK: - FUNCTIONS
    func configureSetTitle(mainTitle: String, subTitle: String) {
        contentView.getTitleView().configureTitle(main: mainTitle, sub: subTitle)
    }
    
    func getContentView() -> ExploreContentView {
        return contentView
    }
}
