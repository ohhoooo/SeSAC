//
//  UIViewController+Extension.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 1/22/25.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel)
        
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
}
