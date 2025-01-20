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
    private var photos: [[Photo]] = Array(repeating: [], count: 3) {
        didSet {
            photoTopicView.goldenHourCollectionView.reloadData()
            photoTopicView.businessWorkCollectionView.reloadData()
            photoTopicView.architectureInteriorCollectionView.reloadData()
        }
    }
    
    // MARK: - life cycles
    override func loadView() {
        view = photoTopicView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureData()
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigation()
    }
    
    override func configureDelegate() {
        photoTopicView.goldenHourCollectionView.delegate = self
        photoTopicView.goldenHourCollectionView.dataSource = self
        
        photoTopicView.businessWorkCollectionView.delegate = self
        photoTopicView.businessWorkCollectionView.dataSource = self
        
        photoTopicView.architectureInteriorCollectionView.delegate = self
        photoTopicView.architectureInteriorCollectionView.dataSource = self
    }
    
    private func configureNavigation() {
        navigationItem.title = "OUR TOPIC"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureData() {
        [Topic.goldenHour, Topic.businessWork, Topic.architectureInterior].enumerated().forEach { (i, e) in
            NetworkManager.shared.fetchPhotoTopic(topic: e) { result in
                switch result {
                case .success(let photos):
                    self.photos[i] = photos
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

// MARK: - extensions
extension PhotoTopicViewController: UICollectionViewDelegate {
    
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
