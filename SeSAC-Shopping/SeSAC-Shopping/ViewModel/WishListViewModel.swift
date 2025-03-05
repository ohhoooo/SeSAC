//
//  WishListViewModel.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 3/5/25.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

final class WishListViewModel {
    
    // MARK: - properties
    private let folderRepository: FolderRepository = FolderTableRepository()
    private let wishListRepository: WishListRepository = WishListTableRepository()
    
    struct Input {
        let changedSearchBarText: ControlProperty<String>
        let searchButtonClicked: ControlEvent<Void>
        let modelSelected: ControlEvent<IndexPath>
    }
    
    struct Output {
        let title: Observable<String>
        let items: BehaviorRelay<[WishList]>
    }
    
    private let items = BehaviorRelay<[WishList]>(value: [])
    private var searchBarText = ""
    private let id: ObjectId
    
    private let disposeBag = DisposeBag()
    
    // MARK: - life cycles
    init(id: ObjectId) {
        self.id = id
    }
    
    // MARK: - methods
    func transform(input: Input) -> Output {
        items.accept(wishListRepository.fetchAllItems(id: id))
        
        input.changedSearchBarText
            .bind(with: self) { owner, value in
                owner.searchBarText = value
            }
            .disposed(by: disposeBag)
        
        input.searchButtonClicked
            .bind(with: self) { owner, _ in
                let folder = owner.folderRepository.fetchItem(id: owner.id)
                let wishList = owner.wishListRepository.createItem(folder: folder, title: owner.searchBarText)
                owner.items.accept(wishList)
            }
            .disposed(by: disposeBag)
        
        input.modelSelected
            .bind(with: self) { owner, value in
                let wishList = owner.wishListRepository.deleteItem(id: owner.id, wishList: owner.items.value[value.item])
                owner.items.accept(wishList)
            }
            .disposed(by: disposeBag)
        
        return Output(
            title: Observable.just(folderRepository.fetchItem(id: id).name),
            items: items
        )
    }
}
