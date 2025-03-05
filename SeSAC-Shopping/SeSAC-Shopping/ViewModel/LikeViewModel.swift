//
//  LikeViewModel.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 3/5/25.
//

import Foundation
import RealmSwift
import RxSwift
import RxCocoa

final class LikeViewModel {
    
    // MARK: - properties
    struct Input {
        let changedSearchBarText: ControlProperty<String>
        let tapLikeButton: PublishRelay<Like>
    }
    
    struct Output {
        let items: BehaviorRelay<[Like]>
        let toast: PublishRelay<String>
    }
    
    private var text = ""
    private var items = BehaviorRelay<[Like]>(value: [])
    
    private let realm = try! Realm()
    private var list: Results<Like>!
    
    private let disposeBag = DisposeBag()
    
    // MARK: - methods
    func transform(input: Input) -> Output {
        list = realm.objects(Like.self)
        items.accept(Array(list))
        
        let toast = PublishRelay<String>()
        
        input.changedSearchBarText
            .bind(with: self) { owner, value in
                owner.text = value
                
                let items = owner.list.where { $0.title.contains(value, options: .caseInsensitive) }
                
                if value.isEmpty {
                    owner.items.accept(Array(owner.list))
                } else {
                    owner.items.accept(Array(items))
                }
            }
            .disposed(by: disposeBag)
        
        input.tapLikeButton
            .bind(with: self) { owner, value in
                let title = value.title
                
                do {
                    try owner.realm.write {
                        owner.realm.delete(value)
                        
                        if owner.text.isEmpty {
                            owner.items.accept(Array(owner.list))
                        } else {
                            let items = owner.list.where { $0.title.contains(owner.text, options: .caseInsensitive) }
                            owner.items.accept(Array(items))
                        }
                        
                        toast.accept("\(title ?? "알 수 없음")이 삭제되었습니다.")
                    }
                } catch {
                    print("실패")
                }
            }
            .disposed(by: disposeBag)
        
        return Output(
            items: items,
            toast: toast
        )
    }
}
