//
//  ViewController.swift
//  TravelTourGuide
//
//  Created by 권정근 on 9/2/24.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    
    // MARK: - UI Components
    private let mainTabBarView: MainTabBarView = {
        let tabBar = MainTabBarView()
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        return tabBar
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBar.isHidden = true
        
        view.addSubview(mainTabBarView)
        setViewControllers()
        configureConstraints()
        
        // 버튼이 눌렀을 때 호출될 클로저 설정
        mainTabBarView.buttonTapped = { [weak self] index in
            self?.selectedIndex = index
        }
        
    }
    
    
    // MARK: - Functions
    private func setViewControllers() {
//        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let exploreVC = UINavigationController(rootViewController: ExploreViewController())
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        let planVC = UINavigationController(rootViewController: PlanViewController())
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        
        viewControllers = [exploreVC, searchVC, planVC, profileVC]
    }
    
    
    // MARK - Layouts
    private func configureConstraints() {
        
        let mainTabBarViewConstraints = [
            mainTabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainTabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainTabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25),
            mainTabBarView.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        NSLayoutConstraint.activate(mainTabBarViewConstraints)
    }
}

