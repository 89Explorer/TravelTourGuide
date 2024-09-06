//
//  DetailInfoTableview.swift
//  TravelTourGuide
//
//  Created by 권정근 on 9/6/24.
//

import UIKit

class DetailInfoTableview: UIView {
    
    // MARK: - UI Components
    private let detailInfoTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(detailInfoTableView)
        
        configureConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layouts
    private func configureConstraints() {
        
        let detailInfoTableViewConstraints = [
            detailInfoTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailInfoTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailInfoTableView.topAnchor.constraint(equalTo: topAnchor),
            detailInfoTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(detailInfoTableViewConstraints)
    }
    
    // MARK: - Functions
    func getDetailInfoTableView() -> UITableView {
        return detailInfoTableView
    }
    
}
