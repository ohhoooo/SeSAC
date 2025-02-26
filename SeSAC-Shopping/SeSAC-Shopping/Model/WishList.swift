//
//  WishList.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 2/26/25.
//

import Foundation

struct WishList: Hashable, Identifiable {
    let id = UUID()
    let title: String
    let date = Date()
}
