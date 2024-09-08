//
//  ExploreViewController.swift
//  TravelTourGuide
//
//  Created by 권정근 on 9/9/24.
//

import UIKit

class ExploreViewController: UIViewController {
    
    // MARK: - VARIABLES
    private let placeCategories = ["자연 관광", "역사 관광", "휴양 관광", "체험 관광", "문화 관광"]
    
    private var selectedIndex: Int = 0
    
    // MARK: - UI COMPONENTS
    private let exploreView: ExploreBasicScrollView = {
        let view = ExploreBasicScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Home"
        
        view.addSubview(exploreView)
        
        configureNavigationBar()
        configureConstraints()
        configureTitleLabel(main: "다음 여행지는 어디인가요?", sub: "모험을 찾고 있다면 여기로")
        
        configureCategoryCollectionViewDelegate()
        
    }
    
    // MARK: - LAYOUTS
    private func configureConstraints() {
        let exploreViewConstraints = [
            exploreView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            exploreView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            exploreView.topAnchor.constraint(equalTo: view.topAnchor),
            exploreView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(exploreViewConstraints)
    }
    
    // MARK: - FUNCTION
    // 네비게이션바 설정 함수
    private func configureNavigationBar() {
        let originalImage = UIImage(named: "trip-logo")
        let scaledSize = CGSize(width: 45, height: 45) // 시스템 버튼과 비슷한 크기
        
        UIGraphicsBeginImageContextWithOptions(scaledSize, false, 0.0)
        originalImage?.draw(in: CGRect(origin: .zero, size: scaledSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // 원본 이미지 색상을 유지하기 위해 렌더링 모드를 .alwaysOriginal로 설정
        let originalColorImage = scaledImage?.withRenderingMode(.alwaysOriginal)
        
        let barButton = UIBarButtonItem(image: originalColorImage, style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = barButton
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = .label
        
        // `UINavigationBarAppearance` 객체 생성
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        // 폰트 로드 실패 시 기본 시스템 폰트로 대체
        let customFont = UIFont(name: "Hakgyoansim Chulseokbu TTF B", size: 28) ?? UIFont.systemFont(ofSize: 24, weight: .bold)
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: customFont
        ]
        
        // 라지 타이틀 관련 설정을 생략하고, 일반 타이틀만 설정
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // 라지 타이틀 비활성화
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func configureTitleLabel(main: String, sub: String) {
        exploreView.configureSetTitle(mainTitle: main, subTitle: sub)
    }
    
    func configureCategoryCollectionViewDelegate() {
        exploreView.getContentView().getCollectionView().getCategoryCollectionview().delegate = self
        exploreView.getContentView().getCollectionView().getCategoryCollectionview().dataSource = self
        exploreView.getContentView().getCollectionView().getCategoryCollectionview().register(PlaceCategoryCollectionViewCell.self, forCellWithReuseIdentifier: PlaceCategoryCollectionViewCell.identifier)
        
        exploreView.getContentView().getCollectionView().getIntroduceCollectionview().delegate = self
        exploreView.getContentView().getCollectionView().getIntroduceCollectionview().dataSource = self
        exploreView.getContentView().getCollectionView().getIntroduceCollectionview().register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
}

// MARK: - EXTENSIONS
extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == exploreView.getContentView().getCollectionView().getCategoryCollectionview() {
            return placeCategories.count
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == exploreView.getContentView().getCollectionView().getCategoryCollectionview() {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceCategoryCollectionViewCell.identifier, for: indexPath) as? PlaceCategoryCollectionViewCell else { return UICollectionViewCell() }
            
            let isSelected = indexPath.item == selectedIndex
            let title = placeCategories[indexPath.item]
            
            
            cell.configureCategory(title: title, isSelected: isSelected)
            
            return cell
        } else if collectionView == exploreView.getContentView().getCollectionView().getIntroduceCollectionview() {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            DispatchQueue.main.async {
                switch self.selectedIndex {
                case 0:
                    cell.backgroundColor = .systemRed
                case 1:
                    cell.backgroundColor = .systemPink
                case 2:
                    cell.backgroundColor = .systemBlue
                default:
                    cell.backgroundColor = .systemCyan
                }
            }
 
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == exploreView.getContentView().getCollectionView().getCategoryCollectionview() {
            
            selectedIndex = indexPath.item
            collectionView.reloadData()
            exploreView.getContentView().getCollectionView().getIntroduceCollectionview().reloadData()
            print("category - \(placeCategories[selectedIndex])")
            
        } else  {
        }
    }
}
