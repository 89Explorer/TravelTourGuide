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
        
        // 셀 크기 설정: 컬렉션 뷰의 크기에 맞추어 설정
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 300)
        // layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.layer.cornerRadius = 10
        collectionView.clipsToBounds = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true // 페이지 단위로 스크롤하게 설정
        // collectionView.alwaysBounceHorizontal = true
        return collectionView
    }()
    
    private let detailTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "전주 한옥 마을"
        label.font = .systemFont(ofSize: 22, weight: .black)
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
            detailTitleLabel.heightAnchor.constraint(equalToConstant: 24)
        ]
        
        NSLayoutConstraint.activate(detailImageCollectionViewConstraints)
        NSLayoutConstraint.activate(detailTitleLabelConstraints)
    }
    
    
    // MARK: - Functions
    func configureDetailCollectionView() -> UICollectionView {
        return detailImageCollectionView
    }
    
    func configureTitleLabel(title: String) {
        
        let modifiedTitle = title.removingParentheses()
        detailTitleLabel.text = modifiedTitle
    }
}
