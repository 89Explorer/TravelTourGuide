//
//  HomeViewController.swift
//  TravelTourGuide
//
//  Created by 권정근 on 9/2/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Variables
    private let categoryTitle: [String] = ["관광지", "문화시설", "숙박", "음식"]
    private let categoryImage: [String] = ["attractions", "newcenter", "sleep", "newTaste"]
    
    
    // MARK: - UI Components
    private let categoryCollectionView: CategoryCollectionView = {
        let collectionView = CategoryCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavbar()
        
        view.addSubview(categoryCollectionView)
        
        categoryCollectionViewDeleagte()
        
        configureConstraints()
    }
    
    
    // MARK: - Layouts
    private func configureConstraints() {
        let categoryCollectionViewCosntraints = [
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            categoryCollectionView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant: 0),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        NSLayoutConstraint.activate(categoryCollectionViewCosntraints)
    }
    
    
    
    // MARK: - Functions
    private func categoryCollectionViewDeleagte() {
        categoryCollectionView.getcategoryCollectionView().delegate = self
        categoryCollectionView.getcategoryCollectionView().dataSource = self
        categoryCollectionView.getcategoryCollectionView().register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }
    
    
    
    
    private func configureNavbar() {
        
        let originalImage = UIImage(named: "trip-logo")
        let scaledSize = CGSize(width: 45, height: 45) // 시스템 버튼과 비슷한 크기
        
        UIGraphicsBeginImageContextWithOptions(scaledSize, false, 0.0)
        originalImage?.draw(in: CGRect(origin: .zero, size: scaledSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // 원본 이미지 색상을 유지하기 위해 렌더링 모드를 .alwaysOriginal로 설정
        let originalColorImage = scaledImage?.withRenderingMode(.alwaysOriginal)
        
        let barButton = UIBarButtonItem(image: originalColorImage, style: .plain, target: self, action: #selector(leftBarButtonTapped))
        navigationItem.leftBarButtonItem = barButton
        
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = .label
    }
    
    
    @objc private func leftBarButtonTapped() {
        print("leftBarButtonTapped() - Called")
    }
}


// MARK: - Extensions
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
        
        let image = categoryImage[indexPath.row]
        let title = categoryTitle[indexPath.row]
        
        cell.configureCategory(with: image, title: title)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell - Tapped() \(indexPath.row)")
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 4
        let spacing: CGFloat = 5
        let totalSpacing = (2 * spacing) + ((numberOfItemsPerRow - 1) * spacing) // 양쪽 패딩 + 셀 간 간격
        
        let width = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
        return CGSize(width: width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
