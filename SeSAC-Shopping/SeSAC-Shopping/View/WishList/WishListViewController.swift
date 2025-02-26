//
//  WishListViewController.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 2/26/25.
//

import UIKit

final class WishListViewController: BaseViewController {
    
    // MARK: - properties
    private let wishListView = WishListView()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, WishList>!
    
    private var registration: UICollectionView.CellRegistration<UICollectionViewListCell, WishList>!
    
    private var list = [
        WishList(title: "여행")
    ]
    
    // MARK: - life cycles
    override func loadView() {
        view = wishListView
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigation()
    }
    
    override func configureDelegate() {
        wishListView.searchBar.delegate = self
        wishListView.collectionView.delegate = self
    }
    
    override func bind() {
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
        
        updateSnapshot()
    }
    
    private func configureNavigation() {
        navigationItem.title = "WishList"
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, WishList>()
        snapshot.appendSections([0])
        snapshot.appendItems(list, toSection: 0)
        
        dataSource.apply(snapshot)
    }
}

// MARK: - extensions
extension WishListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            list.append(WishList(title: text))
            updateSnapshot()
        }
    }
}

extension WishListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        list.remove(at: indexPath.row)
        updateSnapshot()
    }
}
