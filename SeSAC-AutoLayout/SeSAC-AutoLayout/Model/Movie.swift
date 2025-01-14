//
//  Movie.swift
//  SeSAC-AutoLayout
//
//  Created by 김정호 on 1/13/25.
//

import Foundation

struct Movie: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

struct DailyBoxOfficeList: Decodable {
    let rank: String
    let movieNm: String
    let openDt: String
}
