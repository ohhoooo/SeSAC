//
//  PhotoStatistic.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 1/20/25.
//

import Foundation

struct PhotoStatistic: Decodable {
    let downloads: Downloads?
    let views: Downloads?
}

struct Downloads: Decodable {
    let total: Int?
}
