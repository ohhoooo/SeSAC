//
//  WishListTableRepository.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 3/6/25.
//

import Foundation
import RealmSwift

protocol WishListRepository {
    func fetchAllItems(id: ObjectId) -> [WishList]
    func createItem(folder: Folder, title: String) -> [WishList]
    func deleteItem(id: ObjectId, wishList: WishList) -> [WishList]
}

final class WishListTableRepository: WishListRepository {
    
    // MARK: - properties
    private let realm = try! Realm()
    
    // MARK: - methods
    func fetchAllItems(id: ObjectId) -> [WishList] {
        return Array(realm.objects(Folder.self).where { $0.id == id }.first!.wishList)
    }
    
    func createItem(folder: Folder, title: String) -> [WishList] {
        do {
            try realm.write {
                let wishList = WishList(title: title)
                folder.wishList.append(wishList)
            }
        } catch {
            print("WishList 저장 실패")
        }
        
        return fetchAllItems(id: folder.id)
    }
    
    func deleteItem(id: ObjectId, wishList: WishList) -> [WishList] {
        do {
            try realm.write {
                realm.delete(wishList)
            }
        } catch {
            print("WishList 삭제 실패")
        }
        
        return fetchAllItems(id: id)
    }
}
