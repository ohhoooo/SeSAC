//
//  PhotoSearchViewController.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 1/18/25.
//

import UIKit

final class PhotoSearchViewController: BaseViewController {
    
    // MARK: - properties
    private let photoSearchView = PhotoSearchView()
    private var photos: [Photo] = []
    
    // parameters
    private var query = ""
    private var page = 1
    private var perPage = 20
    private var orderBy = Order.relevant
    
    // MARK: - life cycles
    override func loadView() {
        view = photoSearchView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigation()
    }
    
    // MARK: - methods
    override func configureDelegate() {
        photoSearchView.searchBar.delegate = self
        photoSearchView.collectionView.delegate = self
        photoSearchView.collectionView.dataSource = self
    }
    
    override func configureAddTarget() {
        photoSearchView.orderButton.addTarget(self, action: #selector(tappedOrderButton), for: .touchUpInside)
    }
    
    private func configureNavigation() {
        navigationItem.title = "SEARCH PHOTO"
    }
    
    private func configureData() {
        NetworkManager.shared.request(PhotoSearch.self, router: .fetchPhotoSearch(query: query, page: page, perPage: perPage, orderBy: orderBy)) { [weak self] result in
            switch result {
            case .success(let photoSearch):
                guard let self else { return }
                photos.append(contentsOf: photoSearch.photos ?? [])
                photoSearchView.changeGuideLabel(isHidden: photos.isEmpty, comment: "검색 결과가 없어요.")
                photoSearchView.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc
    private func tappedOrderButton(_ sender: UIButton) {
        page = 1
        photos.removeAll()
        
        switch sender.titleLabel?.text {
        case Order.relevant.toKorean:
            orderBy = .latest
            photoSearchView.changeOrderButton(order: Order.latest)
            configureData()
        case Order.latest.toKorean:
            orderBy = .relevant
            photoSearchView.changeOrderButton(order: Order.relevant)
            configureData()
        default:
            print("오류")
        }
    }
}

// MARK: - extensions
extension PhotoSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, text.count > 0 else { return }
        page = 1
        query = text
        photos.removeAll()
        configureData()
        view.endEditing(true)
    }
}

extension PhotoSearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoDetailVC = PhotoDetailViewController()
        photoDetailVC.photo = photos[indexPath.row]
        
        navigationItem.title = ""
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.pushViewController(photoDetailVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        let collectionViewHeight = photoSearchView.collectionView.contentSize.height
        let pagination = collectionViewHeight * 0.2
        
        if contentOffsetY > collectionViewHeight - pagination {
            page += 1
            configureData()
        }
    }
}

extension PhotoSearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoSearchCollectionViewCell.identifier, for: indexPath) as? PhotoSearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.bind(photo: photos[indexPath.row])
        
        return cell
    }
}
