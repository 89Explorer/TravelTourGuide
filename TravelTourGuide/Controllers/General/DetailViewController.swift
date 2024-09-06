//
//  DetailViewController.swift
//  TravelTourGuide
//
//  Created by 권정근 on 9/3/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Variables
    var model: Item?    // HomeViewController로 부터 받은 정보를 담을 변수
    private var imageUrls: [String] = []    // DetailHeaderView의 컬렉션 뷰에 넣을 이미지를 담을 변수
    private var infoData: [(title: String, value: String)] = []    // 여행지 정보 중에서 전화번호, 운영시간 등의 정보를 담을 배열
    
    // MARK: - UI Components
    private let basicScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.clipsToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 20
        return view
    }()
    
    private let detailHeaderView: DetailHeaderView = {
        let detailHeaderView = DetailHeaderView()
        detailHeaderView.translatesAutoresizingMaskIntoConstraints = false
        return detailHeaderView
    }()
    
    private let detailInfoTableView: DetailInfoTableview = {
        let detailIntroTableView = DetailInfoTableview()
        detailIntroTableView.translatesAutoresizingMaskIntoConstraints = false
        return detailIntroTableView
    }()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(basicScrollView)
        basicScrollView.addSubview(contentView)
        contentView.addSubview(detailHeaderView)
        contentView.addSubview(detailInfoTableView)

        configureConstraints()
        configureCollectionViewDeleagte()
        configureIntroTableViewDelegate()
        
        getImage()
        getIntroInfo()
    }
    
    // MARK: - Layouts
    private func configureConstraints() {
        let basicScrollViewConstraints = [
            basicScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            basicScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            basicScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            basicScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let contentViewConstraints = [
            contentView.leadingAnchor.constraint(equalTo: basicScrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: basicScrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: basicScrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: basicScrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: basicScrollView.widthAnchor) // 스크롤뷰가 수평으로 스크롤되지 않게 하기 위함
        ]
        
        let detailHeaderViewConstraints = [
            detailHeaderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            detailHeaderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            detailHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor),
            detailHeaderView.heightAnchor.constraint(equalToConstant: 340),
            // detailHeaderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        let detailInfoTableViewConstraints = [
            detailInfoTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            detailInfoTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            detailInfoTableView.topAnchor.constraint(equalTo: detailHeaderView.bottomAnchor),
            detailInfoTableView.heightAnchor.constraint(equalToConstant: 120),
            detailInfoTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(basicScrollViewConstraints)
        NSLayoutConstraint.activate(contentViewConstraints)
        NSLayoutConstraint.activate(detailHeaderViewConstraints)
        NSLayoutConstraint.activate(detailInfoTableViewConstraints)
    }
    
    
    
    
    // MARK: - Functions
    private func getImage() {
        // `model`이 옵셔널일 때 안전하게 처리
        guard let model = model else {
            print("모델이 없습니다.")
            return
        }
        // 모델이 있으면 이미 정의된 함수 호출
        getImageData(model: model)
    }
    
    private func getIntroInfo() {
        guard let model = model,
              let title = model.title
        else {
            print("모델이 없습니다.")
            return
        }
        // 모델이 있으면 이미 정의된 함수 호출
        detailHeaderView.configureTitleLabel(title: title)
        getIntroInfoData(model: model)
    }
    
    func getImageData(model: Item) {
        let contentid = model.contentid
        NetworkManager.shared.getImageData(contentId: contentid) { results in
            switch results {
            case .success(let items):
                let originImageUrls = self.extractOriginImageUrls(from: items)
                self.imageUrls = originImageUrls
                DispatchQueue.main.async {
                    self.detailHeaderView.configureDetailCollectionView().reloadData()  // 데이터를 받으면 컬렉션 뷰 갱신
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // 네트워크에서 받은 데이터를 처리하여 원하는 정보를 얻기 위한 함수
    func extractOriginImageUrls(from items: ImageItems) -> [String] {
        return items.item.map { $0.originimgurl }
    }
    
    // 네트워크에 관광지 정보 중에서 intro에 해당하는 정보를 갖고 오기 위한 함수
    func getIntroInfoData(model: Item) {
        let contentid = model.contentid
        let contenttypeid = model.contenttypeid
        NetworkManager.shared.getIntroInfoData(contentId: contentid, contentTypeId: contenttypeid) { results in
            switch results {
            case .success(let item):
                var details: [(title: String, value: String)] = []
                guard let detailItem = item.item.first else { return }
                
                if let tel = detailItem.infocenter, !tel.isEmpty {
                    details.append((title: "phone.fill", value: tel))
                }
                
                if let usetime = detailItem.usetime, !usetime.isEmpty {
                    details.append((title: "clock.fill", value: usetime))
                }
                
                if let parking = detailItem.parking, !parking.isEmpty {
                    details.append((title: "parkingsign.circle.fill", value: parking))
                }
                
                if let restdate = detailItem.restdate, !restdate.isEmpty {
                    details.append((title: "calendar", value: restdate))
                }
                
                self.infoData = details
                DispatchQueue.main.async {
                    self.detailInfoTableView.getDetailInfoTableView().reloadData()
                }

            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func configureCollectionViewDeleagte() {
        detailHeaderView.configureDetailCollectionView().delegate = self
        detailHeaderView.configureDetailCollectionView().dataSource = self
        detailHeaderView.configureDetailCollectionView().register(DetailImageCollectionViewCell.self, forCellWithReuseIdentifier: DetailImageCollectionViewCell.identifier)
    }
    
    func configureIntroTableViewDelegate() {
        detailInfoTableView.getDetailInfoTableView().delegate = self
        detailInfoTableView.getDetailInfoTableView().dataSource = self
        detailInfoTableView.getDetailInfoTableView().register(DetailInfoTableViewCell.self, forCellReuseIdentifier: DetailInfoTableViewCell.identifier )
        detailInfoTableView.getDetailInfoTableView().rowHeight = UITableView.automaticDimension
        // detailInfoTableView.getDetailInfoTableView().estimatedRowHeight = 44 // 추정 높이 설정
    }
}

// MARK: - Extensions
extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailImageCollectionViewCell.identifier, for: indexPath) as? DetailImageCollectionViewCell else { return UICollectionViewCell() }
        
        let url = imageUrls[indexPath.item]

        cell.configure(with: url)
        return cell
    }
}


extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailInfoTableViewCell.identifier, for: indexPath) as? DetailInfoTableViewCell else { return UITableViewCell() }
        
        let infodata = infoData[indexPath.row]
        let title = infodata.title
        let value = infodata.value

        cell.configure(title: title, value: value)
        
        cell.selectionStyle = .none
        return cell
    }
}
