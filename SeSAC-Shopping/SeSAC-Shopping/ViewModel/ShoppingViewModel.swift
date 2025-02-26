//
//  ShoppingViewModel.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 2/6/25.
//

import Foundation
import RxSwift
import RxCocoa

final class ShoppingViewModel {
    
    // MARK: - properties
    struct Input {
        let tapWishListBarButtonItem: ControlEvent<Void>
        let text: ControlProperty<String?>
        let searchButtonClicked: ControlEvent<Void>
    }
    
    struct Output {
        let wishListView: ControlEvent<Void>
        let alert: PublishRelay<Void>
        let query: PublishRelay<String>
    }
    
    private var text = ""
    
    private let disposeBag = DisposeBag()
    
    // MARK: - methods
    func transform(input: Input) -> Output {
        let alert = PublishRelay<Void>()
        let query = PublishRelay<String>()
        
        input.text
            .compactMap { $0 }
            .bind(with: self) { owner, value in
                owner.text = value
            }
            .disposed(by: disposeBag)
        
        input.searchButtonClicked
            .bind(with: self) { owner, _ in
                if owner.text.count > 1 {
                    query.accept(owner.text)
                } else {
                    alert.accept(())
                }
            }
            .disposed(by: disposeBag)
        
        return Output(
            wishListView: input.tapWishListBarButtonItem,
            alert: alert,
            query: query
        )
    }
}
