//
//  Lottery.swift
//  SeSAC-Lottery
//
//  Created by 김정호 on 1/14/25.
//

import Foundation

struct Lottery: Decodable {
    let returnValue: String
    let drwNoDate: String
    let drwNo: Int
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
}
