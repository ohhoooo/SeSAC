//
//  Shopping.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 1/16/25.
//

import Foundation

struct Shopping: Decodable {
    let total: Int
    let items: [Item]
}

struct Item: Decodable {
    let title: String?
    let image: String?
    let price: String?
    let mallName: String?
    let productId: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case image
        case price = "lprice"
        case mallName
        case productId
    }
}
