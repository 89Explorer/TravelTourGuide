//
//  ExploreViewController.swift
//  TravelTourGuide
//
//  Created by 권정근 on 9/9/24.
//

import UIKit

class ExploreViewController: UIViewController {
    
    // MARK: - VARIABLES
    private let placeCategories = ["자연 여행", "역사 여행", "휴양 여행", "체험 여행", "문화 여행"]
    private let restaurantCategories = ["한식 음식점", "서양식 음식점", "일식 음식점", "중식 음식점", "카페/전통 찻집"]
    private let accommodationCategories = ["관광호텔", "콘도미니엄", "유스호스텔", "펜션", "모델", "민박", "게스트하우스", "홈스테이", "서비스드레지던스", "한옥"]
    
    private var selectedIndex: Int = 0
    private var restaurantSelectedIndex: Int = 0
    private var accommodationSelectedIndex: Int = 0
    
    private var isLoadingMore: Bool = false
    private var loadIamgeCount: Int = 10
    
    // MARK: - UI COMPONENTS
    private let exploreView: ExploreBasicScrollView = {
        let view = ExploreBasicScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "newlightgray")
        title = "Home"
        
        view.addSubview(exploreView)
        
        configureNavigationBar()
        configureConstraints()
        
        configureTitleLabel(main: "다음 여행지는 어디인가요? 😀", sub: "모험을 찾고 있다면 여기로 😉")
        
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
        let originalImage = UIImage(named: "trip-logo-removebg")
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
        appearance.backgroundColor = UIColor(named: "newlightgray")
        
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
        exploreView.getContentView().getCollectionView().getIntroduceCollectionview().register(PlaceIntroduceCollectionViewCell.self, forCellWithReuseIdentifier: PlaceIntroduceCollectionViewCell.identifier)
        exploreView.getContentView().getCollectionView().getIntroduceCollectionview().register(LoadMoreCollectionViewCell.self, forCellWithReuseIdentifier: LoadMoreCollectionViewCell.identifier)

        
        exploreView.getContentView().getRestaurantCollectionView().getCategoryCollectionview().delegate = self
        exploreView.getContentView().getRestaurantCollectionView().getCategoryCollectionview().dataSource = self
        exploreView.getContentView().getRestaurantCollectionView().getCategoryCollectionview().register(PlaceCategoryCollectionViewCell.self, forCellWithReuseIdentifier: PlaceCategoryCollectionViewCell.identifier)
        
        
        exploreView.getContentView().getRestaurantCollectionView().getIntroduceCollectionview().delegate = self
        exploreView.getContentView().getRestaurantCollectionView().getIntroduceCollectionview().dataSource = self
        exploreView.getContentView().getRestaurantCollectionView().getIntroduceCollectionview().register(PlaceIntroduceCollectionViewCell.self, forCellWithReuseIdentifier: PlaceIntroduceCollectionViewCell.identifier)
        
        
        exploreView.getContentView().getaccommodationCollectionView().getCategoryCollectionview().delegate = self
        exploreView.getContentView().getaccommodationCollectionView().getCategoryCollectionview().dataSource = self
        exploreView.getContentView().getaccommodationCollectionView().getCategoryCollectionview().register(PlaceCategoryCollectionViewCell.self, forCellWithReuseIdentifier: PlaceCategoryCollectionViewCell.identifier)
        
        exploreView.getContentView().getaccommodationCollectionView().getIntroduceCollectionview().delegate = self
        exploreView.getContentView().getaccommodationCollectionView().getIntroduceCollectionview().dataSource = self
        exploreView.getContentView().getaccommodationCollectionView().getIntroduceCollectionview().register(PlaceIntroduceCollectionViewCell.self, forCellWithReuseIdentifier: PlaceIntroduceCollectionViewCell.identifier)
        
    }
    
    private func loadMoreImages() {
        isLoadingMore = true
        DispatchQueue.main.async {
            self.isLoadingMore = false
        }
    }
    
    @objc func loadMoreButtonTapped() {
        isLoadingMore = true
        
        DispatchQueue.main.async {
            self.loadIamgeCount += 10
            self.isLoadingMore = false
        }
        // 데이터 다시 로드
        exploreView.getContentView().getCollectionView().getIntroduceCollectionview().reloadData()
        print("더 보기 버튼 클릭됨 ")
    }
}

// MARK: - EXTENSIONS
extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == exploreView.getContentView().getCollectionView().getCategoryCollectionview() {
            return placeCategories.count
        } else if collectionView == exploreView.getContentView().getCollectionView().getIntroduceCollectionview() {
            return loadIamgeCount + 1
        } else if collectionView == exploreView.getContentView().getRestaurantCollectionView().getCategoryCollectionview() {
            return restaurantCategories.count
        } else if collectionView == exploreView.getContentView().getRestaurantCollectionView().getIntroduceCollectionview() {
            return 10
        } else if collectionView == exploreView.getContentView().getaccommodationCollectionView().getCategoryCollectionview() {
            return accommodationCategories.count
        } else if collectionView == exploreView.getContentView().getaccommodationCollectionView().getIntroduceCollectionview() {
            return 10
        } else  {
            return 5
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
            
            if indexPath.row < loadIamgeCount {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceIntroduceCollectionViewCell.identifier, for: indexPath) as? PlaceIntroduceCollectionViewCell else { return UICollectionViewCell() }
                
                
                DispatchQueue.main.async {
                    switch self.selectedIndex {
                    case 0:
                        cell.backgroundColor = .clear
                        cell.configure()
                    case 1:
                        cell.backgroundColor = .systemPink
                    case 2:
                        cell.backgroundColor = .systemBlue
                    default:
                        cell.backgroundColor = .systemCyan
                    }
                }
                return cell
                
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadMoreCollectionViewCell.identifier, for: indexPath) as? LoadMoreCollectionViewCell else { return UICollectionViewCell() }
                cell.getloadMoreButton().addTarget(self, action: #selector(loadMoreButtonTapped), for: .touchUpInside)
                return cell
            }
            
        } else if collectionView == exploreView.getContentView().getRestaurantCollectionView().getCategoryCollectionview() {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceCategoryCollectionViewCell.identifier, for: indexPath) as? PlaceCategoryCollectionViewCell else { return UICollectionViewCell() }
            
            let isSelected = indexPath.item == restaurantSelectedIndex
            let title = restaurantCategories[indexPath.item]
            
            cell.configureCategory(title: title, isSelected: isSelected)
            
            return cell
            
        } else if collectionView == exploreView.getContentView().getRestaurantCollectionView().getIntroduceCollectionview() {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceIntroduceCollectionViewCell.identifier, for: indexPath) as? PlaceIntroduceCollectionViewCell else { return UICollectionViewCell() }
            
            DispatchQueue.main.async {
                switch self.restaurantSelectedIndex {
                case 0:
                    cell.backgroundColor = .clear
                    cell.configure()
                case 1:
                    cell.backgroundColor = .systemPink
                case 2:
                    cell.backgroundColor = .systemBlue
                default:
                    cell.backgroundColor = .systemCyan
                }
            }
            return cell
        } else  if collectionView == exploreView.getContentView().getaccommodationCollectionView().getCategoryCollectionview() {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceCategoryCollectionViewCell.identifier, for: indexPath) as? PlaceCategoryCollectionViewCell else { return UICollectionViewCell() }
            
            let isSelected = indexPath.item == accommodationSelectedIndex
            let title = accommodationCategories[indexPath.item]
            cell.configureCategory(title: title, isSelected: isSelected)
            
            return cell
        } else if collectionView == exploreView.getContentView().getaccommodationCollectionView().getIntroduceCollectionview() {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceIntroduceCollectionViewCell.identifier, for: indexPath) as? PlaceIntroduceCollectionViewCell else { return UICollectionViewCell() }
            
            DispatchQueue.main.async {
                switch self.accommodationSelectedIndex {
                case 0:
                    cell.backgroundColor = .clear
                    cell.configure()
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
            exploreView.getContentView().getCollectionView().getCategoryCollectionview().reloadData()
            print("category - \(placeCategories[selectedIndex])")
        } else if collectionView == exploreView.getContentView().getCollectionView().getIntroduceCollectionview() {
            exploreView.getContentView().getCollectionView().getIntroduceCollectionview().reloadData()
        } else if collectionView == exploreView.getContentView().getRestaurantCollectionView().getCategoryCollectionview() {
            
            restaurantSelectedIndex = indexPath.item
            print("restaurant = \(restaurantCategories[restaurantSelectedIndex])")
            exploreView.getContentView().getRestaurantCollectionView().getCategoryCollectionview().reloadData()
        } else if collectionView == exploreView.getContentView().getRestaurantCollectionView().getIntroduceCollectionview() {
            exploreView.getContentView().getRestaurantCollectionView().getIntroduceCollectionview().reloadData()
        } else if collectionView == exploreView.getContentView().getaccommodationCollectionView().getCategoryCollectionview(){
            accommodationSelectedIndex = indexPath.item
            print("accommodation = \(accommodationCategories[accommodationSelectedIndex])")
            exploreView.getContentView().getaccommodationCollectionView().getCategoryCollectionview().reloadData()
        } else if collectionView == exploreView.getContentView().getaccommodationCollectionView().getIntroduceCollectionview() {
            exploreView.getContentView().getaccommodationCollectionView().getIntroduceCollectionview().reloadData()
        }
    }
}
