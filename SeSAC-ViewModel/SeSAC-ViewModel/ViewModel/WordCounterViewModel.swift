//
//  WordCounterViewModel.swift
//  SeSAC-ViewModel
//
//  Created by 김정호 on 2/5/25.
//

import Foundation

final class WordCounterViewModel {
    
    let inputTextCount: Observable<Int?> = Observable(nil)
    
    let outputTextCount: Observable<String> = Observable("")
    
    init() {
        inputTextCount.bind { [weak self] _ in
            self?.changedTextView()
        }
    }
    
    private func changedTextView() {
        outputTextCount.value = "현재까지 \(inputTextCount.value ?? 0)글자 작성중"
    }
}
