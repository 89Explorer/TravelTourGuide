//
//  CheckViewController.swift
//  TravelTourGuide
//
//  Created by 권정근 on 9/5/24.
//
import UIKit
import MapKit

class ViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    // 탭 메뉴 컬렉션 뷰
    private let tabBarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let tabItems = ["Details", "Photos", "Reviews"]
    private var selectedIndexPath = IndexPath(item: 0, section: 0)
    
    private let imageCarousel: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 250)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Golden Gate Bridge"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "The Golden Gate Bridge is a suspension bridge spanning the Golden Gate, the one-mile-wide strait connecting San Francisco Bay and the Pacific Ocean."
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()

    private let photosLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        return tableView
    }()

    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add to trip", for: .normal)
        button.backgroundColor = .systemYellow
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let imageNames = ["sleep", "newTaste", "newSleep"]
    private let reviews = [
        ("Jenny", "Beautiful bridge! We walked across it and took many photos."),
        ("Bob", "It was foggy when we visited but still had a great time.")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupScrollView()
        setupLayout()
        setupCollectionView()
        setupTableView()
        setupMapView()
        setupTabBarCollectionView()
    }

    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    private func setupLayout() {
        contentView.addSubview(tabBarCollectionView)
        contentView.addSubview(imageCarousel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(mapView)
        contentView.addSubview(photosLabel)
        contentView.addSubview(tableView)
        contentView.addSubview(addButton)

        NSLayoutConstraint.activate([
            tabBarCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tabBarCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tabBarCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tabBarCollectionView.heightAnchor.constraint(equalToConstant: 50),

            imageCarousel.topAnchor.constraint(equalTo: tabBarCollectionView.bottomAnchor),
            imageCarousel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageCarousel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageCarousel.heightAnchor.constraint(equalToConstant: 250),

            titleLabel.topAnchor.constraint(equalTo: imageCarousel.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            mapView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 200),

            photosLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 16),
            photosLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            photosLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            tableView.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(reviews.count) * 44),

            addButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16),
            addButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            addButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupCollectionView() {
        imageCarousel.dataSource = self
        imageCarousel.delegate = self
        imageCarousel.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reviewCell")
    }

    private func setupMapView() {
        let coordinate = CLLocationCoordinate2D(latitude: 37.8199, longitude: -122.4783)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }

    private func setupTabBarCollectionView() {
        tabBarCollectionView.dataSource = self
        tabBarCollectionView.delegate = self
        tabBarCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "tabCell")
    }

    private func scrollToSection(index: Int) {
        let targetRect: CGRect
        switch index {
        case 0: // Details
            targetRect = titleLabel.frame
        case 1: // Photos
            targetRect = photosLabel.frame
        case 2: // Reviews
            targetRect = tableView.frame
        default:
            return
        }
        scrollView.scrollRectToVisible(targetRect, animated: true)
    }
}

// MARK: - UICollectionView DataSource & Delegate
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == tabBarCollectionView ? tabItems.count : imageNames.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionView == tabBarCollectionView ? "tabCell" : "cell", for: indexPath)
        
        if collectionView == tabBarCollectionView {
            // 탭 메뉴 셀 설정
            let label = UILabel()
            label.text = tabItems[indexPath.item]
            label.textAlignment = .center
            label.textColor = selectedIndexPath == indexPath ? .systemBlue : .black
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            cell.contentView.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
            ])
            
        } else {
            // 이미지 캐러셀 셀 설정
            let imageView = UIImageView(image: UIImage(named: imageNames[indexPath.item]))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            cell.contentView.addSubview(imageView)
            
            NSLayoutConstraint.activate([
                imageView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
                imageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
                imageView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
            ])
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == tabBarCollectionView {
            selectedIndexPath = indexPath
            tabBarCollectionView.reloadData()
            scrollToSection(index: indexPath.item)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == tabBarCollectionView {
            let width = collectionView.frame.width / CGFloat(tabItems.count)
            return CGSize(width: width, height: collectionView.frame.height)
        } else {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    }
}

// MARK: - UITableView DataSource & Delegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath)
        let review = reviews[indexPath.row]
        cell.textLabel?.text = "\(review.0): \(review.1)"
        return cell
    }
}

// MARK: - UIScrollViewDelegate
extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 현재 스크롤 위치에 따라 탭 메뉴 업데이트
        let visibleRect = CGRect(origin: scrollView.contentOffset, size: scrollView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        if let indexPath = indexPathForView(at: visiblePoint) {
            selectedIndexPath = IndexPath(item: indexPath.item, section: 0)
            tabBarCollectionView.reloadData()
        }
    }
    
    private func indexPathForView(at point: CGPoint) -> IndexPath? {
        if titleLabel.frame.contains(point) {
            return IndexPath(item: 0, section: 0)
        } else if photosLabel.frame.contains(point) {
            return IndexPath(item: 1, section: 0)
        } else if tableView.frame.contains(point) {
            return IndexPath(item: 2, section: 0)
        } else {
            return nil
        }
    }
}





