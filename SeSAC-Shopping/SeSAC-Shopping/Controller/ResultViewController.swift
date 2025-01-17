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
    
    // parameters
    var query: String? {
        didSet {
            configureData()
        }
    }
    private var start = 1
    private var sort = Sort.accuracy
    
    // response
    private var shopping: Shopping? {
        didSet {
            guard let shopping else { return }
            resultView.configureData(total: shopping.total)
            
            if items != nil {
                items?.append(contentsOf: shopping.items)
            } else {
                items = shopping.items
            }
        }
    }
    
    private var items: [Item]? {
        didSet {
            resultView.collectionView.reloadData()
        }
    }
    
    // status
    private var selectedButtonTag = 0
    
    // MARK: - life cycles
    override func loadView() {
        view = resultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureAddTarget()
    }
}

// MARK: - extensions
extension ResultViewController {
    private func configureUI() {
        configureNavigation()
        configureCollectionView()
    }
    
    private func configureNavigation() {
        navigationItem.title = query
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    private func configureCollectionView() {
        resultView.collectionView.delegate = self
        resultView.collectionView.dataSource = self
        resultView.collectionView.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: ResultCollectionViewCell.identifier)
    }
    
    private func configureAddTarget() {
        resultView.accuracyButton.addTarget(self, action: #selector(tappedSortButton), for: .touchUpInside)
        resultView.dateButton.addTarget(self, action: #selector(tappedSortButton), for: .touchUpInside)
        resultView.sortByHighPriceButton.addTarget(self, action: #selector(tappedSortButton), for: .touchUpInside)
        resultView.sortByLowPriceButton.addTarget(self, action: #selector(tappedSortButton), for: .touchUpInside)
    }
    
    private func configureData() {
        networkManager.fetchShopping(query: query ?? "", start: start, sort: sort) { result in
            switch result {
            case .success(let shopping):
                self.shopping = shopping
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc
    private func tappedSortButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            if selectedButtonTag != 0 {
                selectedButtonTag = 0
                sort = .accuracy
            }
        case 1:
            if selectedButtonTag != 1 {
                selectedButtonTag = 1
                sort = .date
            }
        case 2:
            if selectedButtonTag != 2 {
                selectedButtonTag = 2
                sort = .sortByHighPrice
            }
        default:
            if selectedButtonTag != 3 {
                selectedButtonTag = 3
                sort = .sortByLowPrice
            }
        }
        
        start = 1
        items?.removeAll()
        configureData()
        resultView.changeButtonColor(tag: selectedButtonTag)
    }
}

extension ResultViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        let collectionViewHeight = resultView.collectionView.contentSize.height
        let pagination = collectionViewHeight * 0.2
        
        if contentOffsetY > collectionViewHeight - pagination {
            start += 30
            configureData()
        }
    }
}

extension ResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.identifier, for: indexPath) as? ResultCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureData(item: items?[indexPath.row])
        
        return cell
    }
}
