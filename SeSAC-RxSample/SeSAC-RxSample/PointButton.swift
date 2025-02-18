//
//  PointButton.swift
//  SeSAC-RxSample
//
//  Created by 김정호 on 2/19/25.
//

import UIKit

class PointButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(UIColor.white, for: .normal)
        backgroundColor = UIColor.black
        layer.cornerRadius = 10
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
