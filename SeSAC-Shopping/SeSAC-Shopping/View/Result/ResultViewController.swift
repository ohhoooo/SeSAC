//
//  ResultViewController.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 1/15/25.
//

import UIKit

final class ResultViewController: BaseViewController {
    
    // MARK: - properties
    private let resultView = ResultView()
    let viewModel = ResultViewModel()
    
    // MARK: - life cycles
    override func loadView() {
        view = resultView
    }
    
    // MARK: - methods
    override func configureDelegate() {
        resultView.collectionView.delegate = self
        resultView.collectionView.dataSource = self
        resultView.collectionView.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: ResultCollectionViewCell.identifier)
    }
    
    override func configureAddTarget() {
        resultView.accuracyButton.addTarget(self, action: #selector(tappedSortButton), for: .touchUpInside)
        resultView.dateButton.addTarget(self, action: #selector(tappedSortButton), for: .touchUpInside)
        resultView.sortByHighPriceButton.addTarget(self, action: #selector(tappedSortButton), for: .touchUpInside)
        resultView.sortByLowPriceButton.addTarget(self, action: #selector(tappedSortButton), for: .touchUpInside)
    }
    
    override func bind() {
        viewModel.outputNavigationTitle.bind { [weak self] title in
            self?.navigationItem.title = title
            self?.navigationController?.navigationBar.tintColor = .black
            self?.navigationController?.navigationBar.topItem?.title = ""
        }
        
        viewModel.outputTotalItemsCount.bind { [weak self] count in
            self?.resultView.configureData(total: count)
        }
        
        viewModel.outputShoppingItems.bind { [weak self] _ in
            self?.resultView.collectionView.reloadData()
        }
        
        viewModel.outputScrollToTop.lazyBind { [weak self] _ in
            self?.resultView.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
        
        viewModel.outputSelectedButtonTag.bind { [weak self] tag in
            self?.resultView.changeButtonColor(tag: tag)
        }
    }
    
    @objc
    private func tappedSortButton(_ sender: UIButton) {
        viewModel.inputSort.value = sender.tag
    }
}

// MARK: - extensions
extension ResultViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        let collectionViewHeight = resultView.collectionView.contentSize.height
        let pagination = collectionViewHeight * 0.2
        
        if contentOffsetY > collectionViewHeight - pagination {
            viewModel.inputStart.value = ()
        }
    }
}

extension ResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.outputShoppingItems.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.identifier, for: indexPath) as? ResultCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureData(item: viewModel.outputShoppingItems.value[indexPath.item])
        
        return cell
    }
}
