//
//  FolderViewModel.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 3/5/25.
//

import Foundation
import RxSwift
import RxCocoa

final class FolderViewModel {
    
    // MARK: - properties
    private let repository: FolderRepository = FolderTableRepository()
    
    struct Input {
        let modelSelected: ControlEvent<Folder>
    }
    
    struct Output {
        let items: Observable<[Folder]>
        let modelSelected: ControlEvent<Folder>
    }
    
    // MARK: - methods
    func transform(input: Input) -> Output {
        let items = Observable.just(repository.fetchAllItems())
        
        return Output(
            items: items,
            modelSelected: input.modelSelected
        )
    }
}
