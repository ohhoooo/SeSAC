//
//  NumbersViewController.swift
//  SeSAC-RxSample
//
//  Created by 김정호 on 2/18/25.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit
import Then

final class NumbersViewController: UIViewController {
    
    // MARK: - properties
    private let number1 = UITextField().then {
        $0.borderStyle = .line
    }
    
    private let number2 = UITextField().then {
        $0.borderStyle = .line
    }
    
    private let number3 = UITextField().then {
        $0.borderStyle = .line
    }
    
    private let plus = UIImageView().then {
        $0.image = UIImage(systemName: "plus")
        $0.tintColor = .black
    }
    
    private let divider = UIView().then {
        $0.backgroundColor = .black
    }
    
    private let result = UILabel().then {
        $0.textAlignment = .right
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .trailing
        $0.spacing = 4
        $0.distribution = .equalSpacing
    }
    
    private let disposeBag = DisposeBag()
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configure()
    }
    
    // MARK: - methods
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(plus)
        view.addSubview(stackView)
        stackView.addArrangedSubview(number1)
        stackView.addArrangedSubview(number2)
        stackView.addArrangedSubview(number3)
        stackView.addArrangedSubview(divider)
        stackView.addArrangedSubview(result)
        
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        number1.snp.makeConstraints {
            $0.width.equalTo(60)
            $0.height.equalTo(40)
        }
        
        number2.snp.makeConstraints {
            $0.width.equalTo(60)
            $0.height.equalTo(40)
        }
        
        number3.snp.makeConstraints {
            $0.width.equalTo(60)
            $0.height.equalTo(40)
        }
        
        plus.snp.makeConstraints {
            $0.centerY.equalTo(number3)
            $0.trailing.equalTo(number3.snp.leading).offset(-4)
            $0.size.equalTo(24)
        }
        
        divider.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(1)
        }
        
        result.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(40)
        }
    }
    
    private func configure() {
        Observable
            .combineLatest(number1.rx.text.orEmpty, number2.rx.text.orEmpty, number3.rx.text.orEmpty) { textValue1, textValue2, textValue3 -> Int in
                return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
            }
            .map { String($0) }
            .bind(to: result.rx.text)
            .disposed(by: disposeBag)
    }
}
