//
//  String+Extension.swift
//  SeSAC-Travel
//
//  Created by 김정호 on 1/3/25.
//

import Foundation

extension String {
    func format() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyMMdd"
        
        let date = formatter.date(from: self)!
        formatter.dateFormat = "yy년 MM월 dd일"
        
        return formatter.string(from: date)
    }
}
