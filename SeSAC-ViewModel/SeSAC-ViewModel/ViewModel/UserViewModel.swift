//
//  UserViewModel.swift
//  SeSAC-ViewModel
//
//  Created by 김정호 on 2/5/25.
//

import Foundation

final class UserViewModel {
    
    private let names = ["James", "Mary", "John", "Patricia", "Robert",
                         "Jennifer", "Michael", "Linda", "William", "Elizabeth",
                         "David", "Barbara", "Richard", "Susan", "Joseph",
                         "Jessica", "Thomas", "Sarah", "Charles", "Karen"]
    
    var person: Observable<[Person]> = Observable([])
    
    var inputLoadButtonTapped: Observable<Void> = Observable(())
    var inputResetButtonTapped: Observable<Void> = Observable(())
    var inputAddButtonTapped: Observable<Void> = Observable(())
    var inputDeleteButtonTapped: Observable<IndexPath?> = Observable(nil)
    
    init() {
        inputLoadButtonTapped.lazyBind { [weak self] _ in
            self?.loadPerson()
        }
        
        inputResetButtonTapped.lazyBind { [weak self] _ in
            self?.resetPerson()
        }
        
        inputAddButtonTapped.lazyBind { [weak self] _ in
            self?.addPerson()
        }
        
        inputDeleteButtonTapped.lazyBind { [weak self] indexPath in
            self?.deletePerson(at: indexPath)
        }
    }
    
    private func loadPerson() {
        person.value.removeAll()
        
        for _ in 0..<5 {
            addPerson()
        }
    }
    
    private func resetPerson() {
        person.value.removeAll()
    }
    
    private func addPerson() {
        let user = Person(name: names.randomElement()!, age: Int.random(in: 20...70))
        person.value.append(user)
    }
    
    private func deletePerson(at indexPath: IndexPath?) {
        guard let indexPath else { return }
        person.value.remove(at: indexPath.row)
    }
}
