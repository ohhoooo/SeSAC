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
    struct Input {
        let changedText: ControlProperty<String?>
        let searchButtonClicked: ControlEvent<Void>
        let modelSelected: ControlEvent<Person>
    }
    
    struct Output {
        let tableViewPersons: BehaviorRelay<[Person]>
        let collectionViewPersons: PublishRelay<[Person]>
    }
    
    private let tableViewPersons = BehaviorRelay<[Person]>(value: [])
    private let collectionViewPersons = PublishRelay<[Person]>()
    
    private var query = ""
    private var tableViewItems: [Person] = []
    private var collectionViewItems: [Person] = []
    
    private let disposeBag = DisposeBag()
    
    // MARK: - methods
    func transform(input: Input) -> Output {
        tableViewItems = fetchPersons()
        tableViewPersons.accept(tableViewItems)
        
        input.changedText
            .orEmpty
            .distinctUntilChanged()
            .bind(with: self) { owner, value in
                owner.query = value
            }
            .disposed(by: disposeBag)
        
        input.searchButtonClicked
            .bind(with: self) { owner, _ in
                let persons = owner.tableViewItems.filter { $0.name.contains(owner.query) }
                owner.tableViewPersons.accept(persons)
            }
            .disposed(by: disposeBag)
        
        input.modelSelected
            .bind(with: self) { owner, value in
                owner.collectionViewItems.append(value)
                owner.collectionViewPersons.accept(owner.collectionViewItems)
            }
            .disposed(by: disposeBag)
        
        return Output(
            tableViewPersons: tableViewPersons,
            collectionViewPersons: collectionViewPersons
        )
    }
    
    private func fetchPersons() -> [Person] {
        guard let data = loadData() else { return [] }
        
        do {
            return try JSONDecoder().decode([Person].self, from: data)
        } catch {
            return []
        }
    }
    
    private func loadData() -> Data? {
        guard let url = Bundle.main.url(forResource: "Person", withExtension: "json") else { return nil }
        
        do {
            return try Data(contentsOf: url)
        } catch {
            return nil
        }
    }
}
