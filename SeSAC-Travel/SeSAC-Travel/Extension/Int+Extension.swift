//
//  Int+Extension.swift
//  SeSAC-Travel
//
//  Created by 김정호 on 1/4/25.
//

import Foundation

extension Int {
    func format() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        return formatter.string(from: NSNumber(value: self)) ?? "0"
    }
}
