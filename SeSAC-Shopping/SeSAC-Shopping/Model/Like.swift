//
//  Like.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 3/4/25.
//

import Foundation
import RealmSwift

class Like: Object {
    @Persisted var title: String?
    @Persisted var image: String?
    @Persisted var price: String?
    @Persisted var mallName: String?
    @Persisted(primaryKey: true) var productId: String
    
    convenience init(title: String?, image: String?, price: String?, mallName: String?, productId: String) {
        self.init()
        
        self.title = title?.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
        self.image = image
        self.price = price
        self.mallName = mallName
        self.productId = productId
    }
}
