//
//  ResultViewModel.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 2/6/25.
//

import Foundation

final class ResultViewModel {
    
    // MARK: - properties
    private var query = ""
    private var start = 1
    private var sort: Sort = .accuracy
    private var shoppingItems: [Item] = []
    
    var inputQuery: Observable<String> = Observable("")
    var inputStart: Observable<Void?> = Observable(nil)
    var inputSort: Observable<Int> = Observable(0)
    
    var outputNavigationTitle: Observable<String> = Observable("")
    var outputTotalItemsCount: Observable<Int> = Observable(0)
    var outputShoppingItems: Observable<[Item]> = Observable([])
    var outputScrollToTop: Observable<Void?> = Observable(nil)
    var outputSelectedButtonTag: Observable<Int> = Observable(0)
    
    // MARK: - life cycles
    init() {
        inputQuery.lazyBind { [weak self] query in
            self?.query = query
            self?.outputNavigationTitle.value = query
            self?.fetchShopping()
        }
        
        inputStart.lazyBind { [weak self] _ in
            self?.start += 30
            self?.fetchShopping()
        }
        
        inputSort.lazyBind { [weak self] tag in
            self?.tappedSortButton(tag: tag)
        }
    }
    
    // MARK: - methods
    private func fetchShopping() {
        NetworkManager.shared.fetchShopping(query: query, start: start, sort: sort) { [weak self] result in
            switch result {
            case .success(let shopping):
                self?.shoppingItems.append(contentsOf: shopping.items)
                self?.outputShoppingItems.value = self?.shoppingItems ?? []
                self?.outputTotalItemsCount.value = shopping.total
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func tappedSortButton(tag: Int) {
        switch tag {
        case 0:
            if sort != .accuracy {
                changeData(tag: 0, sort: .accuracy)
            }
        case 1:
            if sort != .date {
                changeData(tag: 1, sort: .date)
            }
        case 2:
            if sort != .sortByHighPrice {
                changeData(tag: 2, sort: .sortByHighPrice)
            }
        default:
            if sort != .sortByLowPrice {
                changeData(tag: 3, sort: .sortByLowPrice)
            }
        }
    }
    
    private func changeData(tag: Int, sort: Sort) {
        self.sort = sort
        start = 1
        shoppingItems.removeAll()
        fetchShopping()
        outputScrollToTop.value = ()
        outputSelectedButtonTag.value = tag
    }
}
