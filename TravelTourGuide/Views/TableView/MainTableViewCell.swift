//
//  MainTableViewCell.swift
//  TravelTourGuide
//
//  Created by 권정근 on 9/3/24.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    static let identifier = "MainTableViewCell"
    
    // MARK: - UI Components
    private let basicView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "attractions")
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let maintitleLabel: UILabel = {
        let label = UILabel()
        label.text = "전주 한옥 마을"
        label.font = .systemFont(ofSize: 20, weight: .black)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleImageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private let dogCheckImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 18)
        imageView.image = UIImage(systemName: "dog.fill", withConfiguration: imageConfig)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: "New-Green")
        return imageView
    }()
    
    private let titleChatButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 16)
        button.setImage(UIImage(systemName: "bubble", withConfiguration: imageConfig), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let titleFlagButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 18)
        button.setImage(UIImage(systemName: "flag", withConfiguration: imageConfig), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let addressStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let addressImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "location")
        imageView.tintColor = .black
        return imageView
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "경기도 일산시 고잔동 11-3"
        label.font = .systemFont(ofSize: 14, weight: .black)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let phoneStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let phoneImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "phone")
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "111-111"
        label.font = .systemFont(ofSize: 14, weight: .black)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let restStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let restImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar.badge.clock")
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let restLabel: UILabel = {
        let label = UILabel()
        label.text = "상시"
        label.font = .systemFont(ofSize: 14, weight: .black)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        contentView.addSubview(basicView)
        
        basicView.addSubview(mainImageView)
        basicView.addSubview(maintitleLabel)
        basicView.addSubview(titleImageStackView)
        basicView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(addressStackView)
        mainStackView.addArrangedSubview(phoneStackView)
        mainStackView.addArrangedSubview(restStackView)
        
        titleImageStackView.addArrangedSubview(dogCheckImage)
        titleImageStackView.addArrangedSubview(titleChatButton)
        titleImageStackView.addArrangedSubview(titleFlagButton)
        
        addressStackView.addArrangedSubview(addressImage)
        addressStackView.addArrangedSubview(addressLabel)
        
        phoneStackView.addArrangedSubview(phoneImage)
        phoneStackView.addArrangedSubview(phoneLabel)
        
        restStackView.addArrangedSubview(restImage)
        restStackView.addArrangedSubview(restLabel)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layouts
    private func configureConstraints() {
        
        let basicViewConstraints = [
            basicView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            basicView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            basicView.topAnchor.constraint(equalTo: contentView.topAnchor),
            basicView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        
        let mainImageViewConstraints = [
            mainImageView.leadingAnchor.constraint(equalTo: basicView.leadingAnchor, constant: 5),
            mainImageView.trailingAnchor.constraint(equalTo: basicView.trailingAnchor, constant: -5),
            mainImageView.topAnchor.constraint(equalTo: basicView.topAnchor, constant: 10),
            mainImageView.heightAnchor.constraint(equalToConstant: 220)
        ]
        
        let maintitleLabelConstraints = [
            maintitleLabel.leadingAnchor.constraint(equalTo: basicView.leadingAnchor, constant: 5),
            maintitleLabel.trailingAnchor.constraint(equalTo: basicView.trailingAnchor, constant: -5),
            maintitleLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 10),
            maintitleLabel.heightAnchor.constraint(equalToConstant: 28)
        ]
        
        let titleImageStackViewConstarints = [
            titleImageStackView.trailingAnchor.constraint(equalTo: basicView.trailingAnchor, constant: -5),
            titleImageStackView.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 10)
        ]
        
        let mainStackViewConstraints = [
            mainStackView.leadingAnchor.constraint(equalTo: basicView.leadingAnchor, constant: 5),
            mainStackView.trailingAnchor.constraint(equalTo: basicView.trailingAnchor, constant: -5),
            mainStackView.topAnchor.constraint(equalTo: maintitleLabel.bottomAnchor, constant: 10),
            mainStackView.bottomAnchor.constraint(equalTo: basicView.bottomAnchor, constant: -10)
        ]
        
        let addressImageConstraints = [
            addressImage.widthAnchor.constraint(equalToConstant: 20),
            addressImage.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        let phoneImageConstraints = [
            phoneImage.widthAnchor.constraint(equalToConstant: 20),
            phoneImage.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        let restImageConstraints = [
            restImage.widthAnchor.constraint(equalToConstant: 20),
            restImage.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        NSLayoutConstraint.activate(basicViewConstraints)
        NSLayoutConstraint.activate(mainImageViewConstraints)
        NSLayoutConstraint.activate(maintitleLabelConstraints)
        NSLayoutConstraint.activate(titleImageStackViewConstarints)
        NSLayoutConstraint.activate(mainStackViewConstraints)
        NSLayoutConstraint.activate(addressImageConstraints)
        NSLayoutConstraint.activate(phoneImageConstraints)
        NSLayoutConstraint.activate(restImageConstraints)
    }
}
