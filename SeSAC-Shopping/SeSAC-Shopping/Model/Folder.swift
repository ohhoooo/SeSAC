//
//  Folder.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 3/5/25.
//

import Foundation
import RealmSwift

class Folder: Object {
    @Persisted var id: ObjectId
    @Persisted var name: String
    @Persisted var wishList: List<WishList>
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
