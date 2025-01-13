//
//  PaymentViewController.swift
//  SeSAC-AutoLayout
//
//  Created by 김정호 on 1/13/25.
//

import UIKit
import SnapKit

final class PaymentViewController: UIViewController {
    
    // MARK: - properties
    private lazy var membershipButton = {
        let btn = UIButton()
        btn.configureOptionButton(index: 0, title: paymentOptionButtonsTextArray[0])
        return btn
    }()
    
    private lazy var onSitePaymentButton = {
        let btn = UIButton()
        btn.configureOptionButton(index: 1, title: paymentOptionButtonsTextArray[1])
        return btn
    }()
    
    private lazy var couponButton = {
        let btn = UIButton()
        btn.configureOptionButton(index: 2, title: paymentOptionButtonsTextArray[2])
        return btn
    }()
    
    private let paymentOptionStackView = {
        let sv = UIStackView()
        sv.spacing = 0
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.clipsToBounds = true
        sv.backgroundColor = .black
        sv.layer.cornerRadius = 20
        return sv
    }()
    
    private let contentBackgroundView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let nPayImageView = {
        let iv = UIImageView()
        iv.image = .logoNpaybkSmall
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let localButton = {
        let btn = UIButton()
        var config = UIButton.Configuration.filled()
        config.title = "국내"
        config.image = UIImage(systemName: "arrowtriangle.down.fill")?.resize(width: 12, height: 6).withTintColor(.gray)
        config.imagePadding = 2
        config.contentInsets = .init(top: 10, leading: 6, bottom: 10, trailing: 10)
        config.imagePlacement = .trailing
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .gray
        config.attributedTitle?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        btn.configuration = config
        return btn
    }()
    
    private let cancelButton = {
        let btn = UIButton()
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "xmark")?.resize(width: 20, height: 18).withTintColor(.black)
        config.baseBackgroundColor = .clear
        btn.configuration = config
        return btn
    }()
    
    private let securityImageView = {
        let iv = UIImageView()
        iv.image = .security
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let oneTimeAuthLabel = {
        let label = UILabel()
        label.text = "한 번만 인증하고\n비밀번호 없이 결제하세요"
        label.font = .systemFont(ofSize: 19, weight: .heavy)
        label.textColor = UIColor(red: 36/255, green: 36/255, blue: 36/255, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let quickPayButton = {
        let btn = UIButton()
        var config = UIButton.Configuration.filled()
        config.title = "바로결제 사용하기"
        config.image = UIImage(systemName: "checkmark.circle.fill")?.resize(width: 24, height: 24).withTintColor(UIColor(red: 77/255, green: 167/255, blue: 100/255, alpha: 1))
        config.imagePadding = 6
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .black
        config.attributedTitle?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        btn.configuration = config
        return btn
    }()
    
    private let confirmButton = {
        let btn = UIButton()
        var config = UIButton.Configuration.filled()
        config.title = "확인"
        config.buttonSize = .large
        config.cornerStyle = .capsule
        config.baseBackgroundColor = UIColor(red: 76/255, green: 167/255, blue: 139/255, alpha: 1)
        config.baseForegroundColor = .white
        config.attributedTitle?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        btn.configuration = config
        return btn
    }()
    
    private let paymentOptionButtonsTextArray = ["멤버쉽", "현장결제", "쿠폰"]
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 14/255, green: 20/255, blue: 27/255, alpha: 1)
        
        configureHierarchy()
        configureConstraint()
    }
    
    // MARK: - methods
    private func configureHierarchy() {
        view.addSubview(paymentOptionStackView)
        paymentOptionStackView.addArrangedSubview(membershipButton)
        paymentOptionStackView.addArrangedSubview(onSitePaymentButton)
        paymentOptionStackView.addArrangedSubview(couponButton)
        view.addSubview(contentBackgroundView)
        contentBackgroundView.addSubview(nPayImageView)
        contentBackgroundView.addSubview(localButton)
        contentBackgroundView.addSubview(cancelButton)
        contentBackgroundView.addSubview(securityImageView)
        contentBackgroundView.addSubview(oneTimeAuthLabel)
        contentBackgroundView.addSubview(quickPayButton)
        contentBackgroundView.addSubview(confirmButton)
    }
    
    private func configureConstraint() {
        paymentOptionStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
        
        membershipButton.snp.makeConstraints {
            $0.verticalEdges.leading.equalTo(paymentOptionStackView).inset(4)
        }
        
        onSitePaymentButton.snp.makeConstraints {
            $0.verticalEdges.equalTo(paymentOptionStackView).inset(4)
        }
        
        couponButton.snp.makeConstraints {
            $0.verticalEdges.trailing.equalTo(paymentOptionStackView).inset(4)
        }
        
        contentBackgroundView.snp.makeConstraints {
            $0.top.equalTo(paymentOptionStackView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.65)
        }
        
        nPayImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(68)
            $0.height.equalTo(32)
        }
        
        localButton.snp.makeConstraints {
            $0.leading.equalTo(nPayImageView.snp.trailing)
            $0.centerY.equalTo(nPayImageView)
        }
        
        cancelButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.centerY.equalTo(nPayImageView)
        }
        
        securityImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.6)
            $0.size.equalTo(120)
        }
        
        oneTimeAuthLabel.snp.makeConstraints {
            $0.top.equalTo(securityImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.7)
        }
        
        quickPayButton.snp.makeConstraints {
            $0.top.equalTo(oneTimeAuthLabel.snp.bottom).offset(80)
            $0.centerX.width.equalToSuperview()
        }
        
        confirmButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.85)
        }
    }
}

// MARK: - extensions
extension UIButton {
    func configureOptionButton(index: Int, title: String) {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.cornerStyle = .capsule
        config.baseBackgroundColor = (index == 1) ? UIColor(red: 37/255, green: 40/255, blue: 45/255, alpha: 1) : .black
        config.baseForegroundColor = (index == 1) ? .white : .lightGray
        config.attributedTitle?.font = UIFont.boldSystemFont(ofSize: 16)
        self.configuration = config
    }
}
