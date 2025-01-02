//
//  UIViewController+Extension.swift
//  SeSAC-Tamagotchi
//
//  Created by 김정호 on 1/3/25.
//

import UIKit

extension UIViewController {
    func presentAlert(title: String, message: String, style: UIAlertController.Style) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let check = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(check)
        present(alert, animated: true)
    }
}
