//
//  ResultViewModel.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 2/6/25.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

final class ResultViewModel {
    
    // MARK: - properties
    struct Input {
        let tapAccuracyButton: ControlEvent<Void>
        let tapDateButton: ControlEvent<Void>
        let tapSortByHighPriceButton: ControlEvent<Void>
        let tapSortByLowPriceButton: ControlEvent<Void>
    }
    
    struct Output {
        let title: Observable<String>
        let tag: PublishRelay<Int>
        let count: BehaviorRelay<Int>
        let error: PublishRelay<String>
        let items: PublishRelay<[Item]>
    }
    
    private let count = BehaviorRelay(value: 0)
    private let error = PublishRelay<String>()
    private let items = PublishRelay<[Item]>()
    
    private let query: String
    
    private let disposeBag = DisposeBag()
    
    // MARK: - life cycles
    init(query: String) {
        self.query = query
        
        NetworkManager.shared.fetchShopping(query: query, sort: .accuracy)
            .catch { error in
                self.handleError(error: error)
                
                return Observable.just(Shopping(total: 0, items: []))
            }
            .bind(with: self) { owner, value in
                owner.count.accept(value.items.count)
                owner.items.accept(value.items)
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - methods
    func transform(input: Input) -> Output {
        let title = Observable.just(query)
        let tag = PublishRelay<Int>()
        
        input.tapAccuracyButton
            .flatMap {
                NetworkManager.shared.fetchShopping(query: self.query, sort: .accuracy)
                    .catch { error in
                        self.handleError(error: error)
                        
                        return Observable.just(Shopping(total: 0, items: []))
                    }
            }
            .bind(with: self) { owner, value in
                tag.accept(0)
                owner.count.accept(value.items.count)
                owner.items.accept(value.items)
            }
            .disposed(by: disposeBag)
        
        input.tapDateButton
            .flatMap {
                NetworkManager.shared.fetchShopping(query: self.query, sort: .date)
                    .catch { error in
                        self.handleError(error: error)
                        
                        return Observable.just(Shopping(total: 0, items: []))
                    }
            }
            .bind(with: self) { owner, value in
                tag.accept(1)
                owner.count.accept(value.items.count)
                owner.items.accept(value.items)
            }
            .disposed(by: disposeBag)
        
        input.tapSortByHighPriceButton
            .flatMap {
                NetworkManager.shared.fetchShopping(query: self.query, sort: .sortByHighPrice)
                    .catch { error in
                        self.handleError(error: error)
                        
                        return Observable.just(Shopping(total: 0, items: []))
                    }
            }
            .bind(with: self) { owner, value in
                tag.accept(2)
                owner.count.accept(value.items.count)
                owner.items.accept(value.items)
            }
            .disposed(by: disposeBag)
        
        input.tapSortByLowPriceButton
            .flatMap {
                NetworkManager.shared.fetchShopping(query: self.query, sort: .sortByLowPrice)
                    .catch { error in
                        self.handleError(error: error)
                        
                        return Observable.just(Shopping(total: 0, items: []))
                    }
            }
            .bind(with: self) { owner, value in
                tag.accept(3)
                owner.count.accept(value.items.count)
                owner.items.accept(value.items)
            }
            .disposed(by: disposeBag)
        
        return Output(
            title: title,
            tag: tag,
            count: count,
            error: error,
            items: items
        )
    }
    
    private func handleError(error: Error) {
        switch error {
        case APIError.requestParameterError:
            self.error.accept("요청 변수 오류")
        case APIError.callLimitExceededError:
            self.error.accept("호출 한도 초과 오류")
        case APIError.serverError:
            self.error.accept("서버 오류")
        default:
            self.error.accept("알 수 없는 오류")
        }
    }
}
