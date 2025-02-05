//
//  WordCounterViewController.swift
//  SeSAC-ViewModel
//
//  Created by 김정호 on 2/5/25.
//

import UIKit
import SnapKit

final class WordCounterViewController: UIViewController {
    
    // MARK: - properties
    private let textView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.layer.cornerRadius = 8
        textView.textContainerInset = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)
        return textView
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = "현재까지 0글자 작성중"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .systemBlue
        return label
    }()
    
    private let viewModel = WordCounterViewModel()
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupTextView()
        bind()
    }
    
    // MARK: - methods
    private func setupUI() {
        view.backgroundColor = .white
        
        [textView, countLabel].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(countLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(view.snp.width)
        }
    }
    
    private func setupTextView() {
        textView.delegate = self
    }
    
    private func bind() {
        viewModel.outputTextCount.bind { [weak self] text in
            self?.countLabel.text = text
        }
    }
    
    private func updateCharacterCount() {
        viewModel.inputTextCount.value = textView.text.count
    }
}

extension WordCounterViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updateCharacterCount()
    }
}
