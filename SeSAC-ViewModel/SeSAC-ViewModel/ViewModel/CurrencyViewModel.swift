//
//  CurrencyViewModel.swift
//  SeSAC-ViewModel
//
//  Created by 김정호 on 2/5/25.
//

import Foundation

final class CurrencyViewModel {
    
    let inputAmount: Observable<String?> = Observable(nil)
    
    let outputAmount: Observable<String> = Observable("")
    
    init() {
        inputAmount.lazyBind { [weak self] _ in
            self?.tappedConvertButton()
        }
    }
    
    private func tappedConvertButton() {
        guard let inputAmountString = inputAmount.value, let amount = Double(inputAmountString) else {
            outputAmount.value = "올바른 금액을 입력해주세요"
            return
        }
        
        let exchangeRate = 1350.0
        let convertedAmount = amount / exchangeRate
        outputAmount.value = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
    }
}
