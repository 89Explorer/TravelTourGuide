//
//  DetailViewController.swift
//  TravelTourGuide
//
//  Created by 권정근 on 9/3/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    var contentTypeId: String = ""
    var contentId: String = ""
    
    // MARK: - UI Components
    private let basicScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let detailHeaderView: DetailHeaderView = {
        let detailHeaderView = DetailHeaderView()
        detailHeaderView.translatesAutoresizingMaskIntoConstraints = false
        return detailHeaderView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(basicScrollView)
        basicScrollView.addSubview(contentView)
        contentView.addSubview(detailHeaderView)
        
        print(contentId)
        print(contentTypeId)
        configureConstraints()
        getImageData(contentId: contentId)
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
            detailHeaderView.heightAnchor.constraint(equalToConstant: 360)
        ]
        
        NSLayoutConstraint.activate(basicScrollViewConstraints)
        NSLayoutConstraint.activate(contentViewConstraints)
        NSLayoutConstraint.activate(detailHeaderViewConstraints)
    }
    
    
    // MARK: - Functions
    func getImageData(contentId: String) {
        NetworkManager.shared.getImageData(contentId: contentId) { results in
            switch results {
            case .success(let items):
                let originImageUrls = self.extractOriginImageUrls(from: items)
                print(originImageUrls) // 추출된 이미지 URL을 사용
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func extractOriginImageUrls(from items: ImageItems) -> [String] {
        return items.item.map { $0.originimgurl }
    }
}
