//
//  WishListViewController.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 2/26/25.
//

import UIKit
import RxSwift
import RxCocoa

final class WishListViewController: BaseViewController {
    
    // MARK: - properties
    private let wishListView = WishListView()
    private let viewModel: WishListViewModel
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, WishList>!
    private var registration: UICollectionView.CellRegistration<UICollectionViewListCell, WishList>!
    
    private let disposeBag = DisposeBag()
    
    // MARK: - life cycles
    init(viewModel: WishListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = wishListView
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureCollectionView()
    }
    
    override func bind() {
        let input = WishListViewModel.Input(
            changedSearchBarText: wishListView.searchBar.rx.text.orEmpty,
            searchButtonClicked: wishListView.searchBar.rx.searchButtonClicked,
            modelSelected: wishListView.collectionView.rx.itemSelected
        )
        
        let output = viewModel.transform(input: input)
        
        output.title
            .bind(with: self) { owner, value in
                owner.configureNavigation(title: value)
            }
            .disposed(by: disposeBag)
        
        output.items
            .bind(with: self) { owner, value in
                owner.updateSnapshot(list: value)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureCollectionView() {
        registration = UICollectionView.CellRegistration<UICollectionViewListCell, WishList> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            
            content.text = itemIdentifier.title
            content.textProperties.color = .brown
            content.textProperties.font = .boldSystemFont(ofSize: 20)
            
            content.secondaryText = itemIdentifier.date.formatted(.dateTime)
            content.secondaryTextProperties.color = .blue
            
            content.image = UIImage(systemName: "star")
            content.imageProperties.tintColor = .orange
            
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listCell()
            backgroundConfig.backgroundColor = .yellow
            backgroundConfig.cornerRadius = 4
            backgroundConfig.strokeColor = .systemRed
            backgroundConfig.strokeWidth = 2
            
            cell.backgroundConfiguration = backgroundConfig
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: wishListView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: self.registration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
    }
    
    private func configureNavigation(title: String) {
        navigationItem.title = title
    }
    
    private func updateSnapshot(list: [WishList]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, WishList>()
        snapshot.appendSections([0])
        snapshot.appendItems(list, toSection: 0)
        
        dataSource.apply(snapshot)
    }
}
