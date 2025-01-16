//
//  UIViewController+Extension.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 1/16/25.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, button: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let check = UIAlertAction(title: button, style: .default) { _ in
            completion()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(check)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}
