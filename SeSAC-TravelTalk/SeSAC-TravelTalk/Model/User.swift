//
//  User.swift
//  SeSAC-TravelTalk
//
//  Created by 김정호 on 1/10/25.
//

import Foundation

enum User: String {
    case hue = "Hue"
    case jack = "Jack"
    case bran = "Bran"
    case den = "Den"
    case user = "Jeongho Kim"
    case other_friend = "내옆자리의앞자리에개발잘하는친구"
    case simsim = "심심이"
    
    var profileImage: String {
        return rawValue
    }
}
