//
//  PhotoDetailViewController.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 1/20/25.
//

import UIKit

final class PhotoDetailViewController: BaseViewController {
    
    // MARK: - properties
    private let photoDetailView = PhotoDetailView()
    
    var photo: Photo? {
        didSet {
            bind()
        }
    }
    
    // MARK: - life cycles
    override func loadView() {
        view = photoDetailView
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigation()
    }
    
    override func bind() {
        guard let photo else { return }
        guard let photoId = photo.id else { return photoDetailView.bind(photo: photo) }
        
        NetworkManager.shared.fetchPhotoStatistic(photoId: photoId) { result in
            switch result {
            case .success(let photoStatistic):
                self.photoDetailView.bind(photo: photo, photoStatistic: photoStatistic)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configureNavigation() {
        navigationItem.title = ""
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
    }
}
