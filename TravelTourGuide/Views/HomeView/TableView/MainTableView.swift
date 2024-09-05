//
//  MainTableView.swift
//  TravelTourGuide
//
//  Created by 권정근 on 9/3/24.
//

import UIKit

class MainTableView: UIView {
    
    // MARK: - UI Components
    private let basicView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    private let mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(basicView)

        basicView.addSubview(mainTableView)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layouts
    private func configureConstraints() {
        
        let basicViewConstraints = [
            basicView.leadingAnchor.constraint(equalTo: leadingAnchor),
            basicView.trailingAnchor.constraint(equalTo: trailingAnchor),
            basicView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            basicView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        let mainTableViewConstraints = [
            mainTableView.leadingAnchor.constraint(equalTo: basicView.leadingAnchor, constant: 5),
            mainTableView.trailingAnchor.constraint(equalTo: basicView.trailingAnchor, constant: -5),
            mainTableView.topAnchor.constraint(equalTo: basicView.topAnchor, constant: 5),
            mainTableView.bottomAnchor.constraint(equalTo: basicView.bottomAnchor, constant: -5)
            
        ]
        
        NSLayoutConstraint.activate(basicViewConstraints)
        NSLayoutConstraint.activate(mainTableViewConstraints)
    }
    
    
    // MARK: - Functions
    func getMainTable() -> UITableView {
        return mainTableView
    }
}
