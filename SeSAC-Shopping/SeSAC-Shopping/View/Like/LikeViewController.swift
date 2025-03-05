//
//  LikeViewController.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 3/4/25.
//

import UIKit
import RxSwift
import RxCocoa

final class LikeViewController: BaseViewController {
    
    // MARK: - properties
    private let likeView = LikeView()
    private let viewModel = LikeViewModel()
    
    private let tapLikeButton = PublishRelay<Like>()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - life cycles
    override func loadView() {
        view = likeView
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigation()
    }
    
    override func bind() {
        let input = LikeViewModel.Input(
            changedSearchBarText: likeView.searchBar.rx.text.orEmpty,
            tapLikeButton: tapLikeButton
        )
        
        let output = viewModel.transform(input: input)
        
        output.items
            .bind(to: likeView.collectionView.rx.items(
                cellIdentifier: ResultCollectionViewCell.identifier,
                cellType: ResultCollectionViewCell.self)
            ) { (row, element, cell) in
                let item = Item(title: element.title,
                                image: element.image,
                                price: element.price,
                                mallName: element.mallName,
                                productId: element.productId)
                
                cell.configureData(item: item)
                cell.bindLike(like: true)
                
                cell.likeButton.rx.tap
                    .bind(with: self) { owner, _ in
                        owner.tapLikeButton.accept(element)
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        output.toast
            .bind(with: self) { owner, value in
                owner.presentToast(message: value)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureNavigation() {
        navigationItem.title = "좋아요 목록"
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
}
