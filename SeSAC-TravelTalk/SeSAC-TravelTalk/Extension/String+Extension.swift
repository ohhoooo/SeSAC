//
//  String+Extension.swift
//  SeSAC-TravelTalk
//
//  Created by 김정호 on 1/10/25.
//

import Foundation

extension String {
    func format() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let date = formatter.date(from: self) else { return "00.00.00" }
        formatter.dateFormat = "yy.MM.dd"
        
        return formatter.string(from: date)
    }
    
    func formatTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.locale = Locale(identifier: "ko_KR")
        
        guard let date = formatter.date(from: self) else { return "00.00.00" }
        formatter.dateFormat = "hh:mm a"
        
        return formatter.string(from: date)
    }
}
