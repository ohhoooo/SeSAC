//
//  PhotoSearch.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 1/18/25.
//

import Foundation

struct PhotoSearch: Decodable {
    let total: Int?
    let totalPages: Int?
    let photos: [Photo]?
    
    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case photos = "results"
    }
}
