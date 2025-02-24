//
//  HomeworkViewModel.swift
//  SeSAC-RxSample02
//
//  Created by 김정호 on 2/19/25.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeworkViewModel {
    
    // MARK: - properties
    let disposeBag = DisposeBag()
    
    struct Input {
        let tableViewDatas: BehaviorSubject<[Person]>
        let collectionViewDatas: BehaviorSubject<[Person]>
        let modelSelected: ControlEvent<Person>
        let searchButtonClicked: ControlEvent<Void>
    }
    
    struct Output {
        let tableViewDatas: BehaviorSubject<[Person]>
        let collectionViewDatas: BehaviorSubject<[Person]>
        let modelSelected: ControlEvent<Person>
        let searchButtonClicked: ControlEvent<Void>
    }
    
    // MARK: - methods
    func transform(input: Input) -> Output {
        return Output(tableViewDatas: input.tableViewDatas,
                      collectionViewDatas: input.collectionViewDatas,
                      modelSelected: input.modelSelected,
                      searchButtonClicked: input.searchButtonClicked
        )
    }
}
