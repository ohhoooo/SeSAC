//
//  FolderTableRepository.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 3/5/25.
//

import Foundation
import RealmSwift

protocol FolderRepository {
    func fetchItem(id: ObjectId) -> Folder
    func fetchAllItems() -> [Folder]
    func createItems()
}

final class FolderTableRepository: FolderRepository {
    
    // MARK: - properties
    private let realm = try! Realm()
    
    // MARK: - methods
    func fetchItem(id: ObjectId) -> Folder {
        return realm.objects(Folder.self).where { $0.id == id }.first!
    }
    
    func fetchAllItems() -> [Folder] {
        if realm.objects(Folder.self).isEmpty {
            createItems()
        }
        
        return Array(realm.objects(Folder.self))
    }
    
    func createItems() {
        do {
            try realm.write {
                let shopping = Folder(name: "쇼핑")
                let travel = Folder(name: "여행")
                let experience = Folder(name: "경험")
                let study = Folder(name: "공부")
                
                realm.add(shopping)
                realm.add(travel)
                realm.add(experience)
                realm.add(study)
            }
        } catch {
            print("Folder 저장 실패")
        }
    }
}
