//
//  LocationSpotViewController.swift
//  TravelTourGuide
//
//  Created by 권정근 on 9/10/24.
//

import UIKit

class LocationSpotViewController: UIViewController {

    // MARK: - UI COMPONENTS
    private let locationSpotView: LocationSpotScrollView = {
        let view = LocationSpotScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view 
    }()
    
    // MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = "HOME"
        getTitleView(main: "현재 동동이님 주변 명소 리스트", sub: "현재 위치: 서울 고강동 339-3 ")
        
        view.addSubview(locationSpotView)
        configureNavigationBar()
        configureConstraints()
    }
    
    // MARK: - LAYOUTS
    private func configureConstraints() {
        let locationSpotViewConstraints = [
            locationSpotView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            locationSpotView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationSpotView.topAnchor.constraint(equalTo: view.topAnchor),
            locationSpotView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(locationSpotViewConstraints)
    }
    
    
    // MARK: - FUNCTIONS
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
        
        navigationController?.navigationBar.tintColor = .black
        
        // `UINavigationBarAppearance` 객체 생성
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        // 폰트 로드 실패 시 기본 시스템 폰트로 대체
        let customFont = UIFont(name: "Hakgyoansim Chulseokbu TTF B", size: 24) ?? UIFont.systemFont(ofSize: 22, weight: .bold)
        
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
    
    private func getTitleView(main: String, sub: String) {
        locationSpotView.getlocationView().getlocationSpotTitleView().configureTitle(main: main, sub: sub)
    }
}
