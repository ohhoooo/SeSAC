//
//  WishList.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 2/26/25.
//

import Foundation
import RealmSwift

class WishList: Object {
    @Persisted var id: ObjectId
    @Persisted var title: String
    @Persisted var date = Date()
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
}
