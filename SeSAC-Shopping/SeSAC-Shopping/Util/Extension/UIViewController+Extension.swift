//
//  UIViewController+Extension.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 1/16/25.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, button: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let check = UIAlertAction(title: button, style: .default)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(check)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    func presentToast(message: String) {
        view.makeToast(message,
                       duration: 2.0,
                       position: .bottom,
                       title: "알림",
                       image: nil,
                       style: .init())
    }
}
