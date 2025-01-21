//
//  PhotoTopicViewController.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 1/20/25.
//

import UIKit

final class PhotoTopicViewController: BaseViewController {
    
    // MARK: - properties
    private let photoTopicView = PhotoTopicView()
    private var photos: [[Photo]] = Array(repeating: [], count: 3)
    
    // MARK: - life cycles
    override func loadView() {
        view = photoTopicView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigation()
    }
    
    // MARK: - methods
    override func configureDelegate() {
        photoTopicView.goldenHourCollectionView.delegate = self
        photoTopicView.goldenHourCollectionView.dataSource = self
        
        photoTopicView.businessWorkCollectionView.delegate = self
        photoTopicView.businessWorkCollectionView.dataSource = self
        
        photoTopicView.architectureInteriorCollectionView.delegate = self
        photoTopicView.architectureInteriorCollectionView.dataSource = self
    }
    
    override func bind() {
        let group = DispatchGroup()
        
        [Topic.goldenHour, Topic.businessWork, Topic.architectureInterior].enumerated().forEach { (i, e) in
            group.enter()
            
            NetworkManager.shared.request([Photo].self, router: .fetchPhotos(topic: e)) { [weak self] result in
                switch result {
                case .success(let photos):
                    self?.photos[i] = photos
                    group.leave()
                case .failure(let error):
                    print(error.localizedDescription)
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.photoTopicView.goldenHourCollectionView.reloadData()
            self?.photoTopicView.businessWorkCollectionView.reloadData()
            self?.photoTopicView.architectureInteriorCollectionView.reloadData()
        }
    }
    
    private func configureNavigation() {
        navigationItem.title = "OUR TOPIC"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - extensions
extension PhotoTopicViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoDetailVC = PhotoDetailViewController()
        
        if collectionView == photoTopicView.goldenHourCollectionView {
            photoDetailVC.photo = photos[0][indexPath.row]
        } else if collectionView == photoTopicView.businessWorkCollectionView {
            photoDetailVC.photo = photos[1][indexPath.row]
        } else {
            photoDetailVC.photo = photos[2][indexPath.row]
        }
        
        navigationItem.title = ""
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.pushViewController(photoDetailVC, animated: true)
    }
}

extension PhotoTopicViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == photoTopicView.goldenHourCollectionView {
            return photos[0].count
        } else if collectionView == photoTopicView.businessWorkCollectionView {
            return photos[1].count
        } else {
            return photos[2].count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoTopicCollectionViewCell.identifier, for: indexPath) as? PhotoTopicCollectionViewCell else { return UICollectionViewCell() }
        
        if collectionView == photoTopicView.goldenHourCollectionView {
            cell.bind(photo: photos[0][indexPath.row])
        } else if collectionView == photoTopicView.businessWorkCollectionView {
            cell.bind(photo: photos[1][indexPath.row])
        } else {
            cell.bind(photo: photos[2][indexPath.row])
        }
        
        return cell
    }
}
