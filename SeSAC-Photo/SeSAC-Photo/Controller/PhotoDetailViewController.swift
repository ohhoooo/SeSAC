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
    let viewModel = PhotoDetailViewModel()
    
    // MARK: - life cycles
    override func loadView() {
        view = photoDetailView
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigation()
    }
    
    override func bind() {
        viewModel.output.photo.bind { [weak self] photo in
            self?.photoDetailView.bindPhoto(photo: photo)
        }
        
        viewModel.output.photoStatistic.lazyBind { [weak self] photoStatistic in
            self?.photoDetailView.bindPhotoStatistic(photoStatistic: photoStatistic)
        }
    }
    
    private func configureNavigation() {
        navigationItem.title = ""
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
    }
}
