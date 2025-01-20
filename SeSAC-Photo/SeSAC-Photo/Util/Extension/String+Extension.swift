//
//  String+Extension.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 1/20/25.
//

import Foundation

extension String {
    func format() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let date = formatter.date(from: self)!
        formatter.dateFormat = "yyyy년 MM월 dd일 게시됨"
        
        return formatter.string(from: date)
    }
}
