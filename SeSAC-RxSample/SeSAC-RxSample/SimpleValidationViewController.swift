//
//  SimpleValidationViewController.swift
//  SeSAC-RxSample
//
//  Created by 김정호 on 2/18/25.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit
import Then

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

final class SimpleValidationViewController: UIViewController {
    
    // MARK: - properties
    private let userNameLabel = UILabel().then {
        $0.text = "Username"
    }
    
    private let userNameTextField = UITextField().then {
        $0.borderStyle = .line
    }
    
    private let userNameValidLabel = UILabel().then {
        $0.text = "Label"
        $0.textColor = .systemRed
    }
    
    private let passwordLabel = UILabel().then {
        $0.text = "Password"
    }
    
    private let passwordTextField = UITextField().then {
        $0.borderStyle = .line
    }
    
    private let passwordValidLabel = UILabel().then {
        $0.text = "Label"
        $0.textColor = .systemRed
    }
    
    private let doSomethingButton = UIButton().then {
        $0.setTitle("Do something", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = UIColor(red: 117/255, green: 255/255, blue: 129/255, alpha: 1)
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 8
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
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(userNameLabel)
        stackView.addArrangedSubview(userNameTextField)
        stackView.addArrangedSubview(userNameValidLabel)
        stackView.addArrangedSubview(passwordLabel)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(passwordValidLabel)
        stackView.addArrangedSubview(doSomethingButton)
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        userNameTextField.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        doSomethingButton.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
    
    private func configure() {
        userNameValidLabel.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordValidLabel.text = "Password has to be at least \(minimalPasswordLength) characters"
        
        let usernameValid = userNameTextField.rx.text.orEmpty
            .map { $0.count >= minimalUsernameLength }
            .share(replay: 1)
        
        let passwordValid = passwordTextField.rx.text.orEmpty
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1)
        
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
        
        usernameValid
            .bind(to: passwordTextField.rx.isEnabled)
            .disposed(by: disposeBag)
        
        usernameValid
            .bind(to: userNameValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: passwordValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        everythingValid
            .bind(to: doSomethingButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        doSomethingButton.rx.tap
            .subscribe(onNext: { [weak self] _ in self?.showAlert() } )
            .disposed(by: disposeBag)
    }
    
    private func showAlert() {
        let alert = UIAlertController(
            title: "RxExample",
            message: "This is wonderful",
            preferredStyle: .alert
        )
        let defaultAction = UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}
