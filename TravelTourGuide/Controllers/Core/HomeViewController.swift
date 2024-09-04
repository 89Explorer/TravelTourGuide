//
//  HomeViewController.swift
//  TravelTourGuide
//
//  Created by 권정근 on 9/2/24.
//

import UIKit

// MARK: - Enum
enum ContentCategory: String {
    case attractions = "12"
    case facilities = "14"
    case accommodation = "32"
    case restaurant = "38"
    
    var contentId: String {
        return self.rawValue
    }
}


// MARK: - Class
class HomeViewController: UIViewController {
    
    // MARK: - Variables
    private let categoryTitle: [String] = ["관광지", "문화시설", "숙박", "음식"]
    private let categoryImage: [String] = ["attractions", "newcenter", "sleep", "newTaste"]
    private var selectedIndex: Int = 0 // 선택된 버튼의 인덱스
    private var items: [Item] = []
    
    
    // MARK: - UI Components
    private let categoryCollectionView: CategoryCollectionView = {
        let collectionView = CategoryCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let mainTableView: MainTableView = {
        let tableView = MainTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavbar()
        
        view.addSubview(categoryCollectionView)
        view.addSubview(mainTableView)
        
        categoryCollectionViewDeleagte()
        mainTableViewDelegate()
        
        configureConstraints()
        getRandomPageData(contentId: "12")
    }
    
    
    // MARK: - Layouts
    private func configureConstraints() {
        let categoryCollectionViewCosntraints = [
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            categoryCollectionView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant: 0),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        let mainTableViewConstraints = [
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            mainTableView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 10),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -75)
        ]
        
        NSLayoutConstraint.activate(categoryCollectionViewCosntraints)
        NSLayoutConstraint.activate(mainTableViewConstraints)
    }
    
    
    
    // MARK: - Functions
    private func categoryCollectionViewDeleagte() {
        categoryCollectionView.getcategoryCollectionView().delegate = self
        categoryCollectionView.getcategoryCollectionView().dataSource = self
        categoryCollectionView.getcategoryCollectionView().register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }
    
    private func mainTableViewDelegate() {
        mainTableView.getMainTable().delegate = self
        mainTableView.getMainTable().dataSource = self
        mainTableView.getMainTable().register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
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
    
    private func getRandomPageData(contentId: String) {
        NetworkManager.shared.fetchRandomPageData(contentId: contentId) { [weak self] results in
            switch results {
            case .success(let items):
                // firstImage가 nil이 아니고, 빈 문자열이 아닌 모든 요소 확인
                let validItems = items.filter {
                    if let firstImage = $0.firstimage {
                        return !firstImage.isEmpty
                    }
                    return false
                }
                DispatchQueue.main.async {
                    self?.items = validItems
                    self?.mainTableView.getMainTable().reloadData()
                    
                    // 데이터를 다시 로드한 후 첫 번째 행으로 스크롤
                    if !items.isEmpty {
                        self?.mainTableView.getMainTable().scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
        selectedIndex = indexPath.item
        
        var selectedCategory: ContentCategory?
        switch selectedIndex{
        case 0:
            selectedCategory = .attractions
        case 1:
            selectedCategory = .facilities
        case 2:
            selectedCategory = .accommodation
        case 3:
            selectedCategory = .restaurant
        default:
            break
        }
        
        if let category = selectedCategory {
            getRandomPageData(contentId: category.contentId)
        }
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


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        
        let model = items[indexPath.row]
        cell.configureMainTableViewCellData(with: model)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 356
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = DetailViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
