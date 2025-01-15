//
//  ResultViewController.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 1/15/25.
//

import UIKit

final class ResultViewController: UIViewController {
    
    // MARK: - properties
    private let resultView = ResultView()
    private let networkManager = NetworkManager.shared
    
    var keyword: String? {
        didSet {
            guard let keyword else { return }
            configureData(keyword: keyword)
        }
    }
    
    private var shopping: Shopping? {
        didSet {
            guard let shopping else { return }
            resultView.configureData(total: shopping.total)
            resultView.collectionView.reloadData()
        }
    }
    
    // MARK: - life cycles
    override func loadView() {
        view = resultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
}

// MARK: - extensions
extension ResultViewController {
    private func configureUI() {
        configureNavigation()
        configureCollectionView()
    }
    
    private func configureNavigation() {
        navigationItem.title = keyword
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    private func configureCollectionView() {
        resultView.collectionView.dataSource = self
        resultView.collectionView.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: ResultCollectionViewCell.identifier)
    }
    
    private func configureData(keyword: String) {
        networkManager.fetchShopping(query: keyword) { result in
            switch result {
            case .success(let shopping):
                self.shopping = shopping
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopping?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.identifier, for: indexPath) as? ResultCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureData(item: shopping?.items[indexPath.row])
        
        return cell
    }
}
