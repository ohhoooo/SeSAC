//
//  ViewController.swift
//  SeSAC-AutoLayout
//
//  Created by 김정호 on 1/1/25.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - properties
    @IBOutlet weak var paymentOptionButtonsBackgroundView: UIView!
    @IBOutlet var paymentOptionButtons: [UIButton]!
    @IBOutlet weak var contentBackgroundView: UIView!
    @IBOutlet weak var nPayImageView: UIImageView!
    @IBOutlet weak var localButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var securityImageView: UIImageView!
    @IBOutlet weak var oneTimeAuthLabel: UILabel!
    @IBOutlet weak var quickPayButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    private let paymentOptionButtonsTextArray = ["멤버쉽", "현장결제", "쿠폰"]
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - methods
    private func configureUI() {
        configureView()
        configureButton()
        configureImageView()
        configureLabel()
    }
    
    private func configureView() {
        view.backgroundColor = UIColor(red: 14/255, green: 20/255, blue: 27/255, alpha: 1)
        
        paymentOptionButtonsBackgroundView.clipsToBounds = true
        paymentOptionButtonsBackgroundView.backgroundColor = .black
        paymentOptionButtonsBackgroundView.layer.cornerRadius = 20
        
        contentBackgroundView.clipsToBounds = true
        contentBackgroundView.layer.cornerRadius = 16
    }
    
    private func configureButton() {
        paymentOptionButtons.enumerated().forEach { (i, e) in
            var config = UIButton.Configuration.filled()
            config.title = paymentOptionButtonsTextArray[i]
            config.cornerStyle = .capsule
            config.baseBackgroundColor = .black
            config.baseForegroundColor = .lightGray
            config.attributedTitle?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            e.configuration = config
        }
        paymentOptionButtons[1].configuration?.baseBackgroundColor = UIColor(red: 37/255, green: 40/255, blue: 45/255, alpha: 1)
        paymentOptionButtons[1].configuration?.baseForegroundColor = .white
        
        var config = UIButton.Configuration.filled()
        config.title = "국내"
        config.image = UIImage(systemName: "arrowtriangle.down.fill")?.resize(width: 12, height: 6).withTintColor(.gray)
        config.imagePadding = 2
        config.contentInsets = .init(top: 10, leading: 6, bottom: 10, trailing: 10)
        config.imagePlacement = .trailing
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .gray
        config.attributedTitle?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        localButton.configuration = config
        
        config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "xmark")?.resize(width: 20, height: 18).withTintColor(.black)
        config.baseBackgroundColor = .clear
        cancelButton.configuration = config
        
        config = UIButton.Configuration.filled()
        config.title = "바로결제 사용하기"
        config.image = UIImage(systemName: "checkmark.circle.fill")?.resize(width: 24, height: 24).withTintColor(UIColor(red: 77/255, green: 167/255, blue: 100/255, alpha: 1))
        config.imagePadding = 6
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .black
        config.attributedTitle?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        quickPayButton.configuration = config
        
        config = UIButton.Configuration.filled()
        config.title = "확인"
        config.buttonSize = .large
        config.cornerStyle = .capsule
        config.baseBackgroundColor = UIColor(red: 76/255, green: 167/255, blue: 139/255, alpha: 1)
        config.baseForegroundColor = .white
        config.attributedTitle?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        confirmButton.configuration = config
    }
    
    private func configureImageView() {
        nPayImageView.image = .logoNpaybkSmall
        securityImageView.image = .security
    }
    
    private func configureLabel() {
        oneTimeAuthLabel.text = "한 번만 인증하고\n비밀번호 없이 결제하세요"
        oneTimeAuthLabel.font = UIFont.systemFont(ofSize: 19, weight: .heavy)
        oneTimeAuthLabel.textColor = UIColor(red: 36/255, green: 36/255, blue: 36/255, alpha: 1)
        oneTimeAuthLabel.numberOfLines = 0
    }
}

// MARK: - extensions
extension UIImage {
    func resize(width: CGFloat, height: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
        
        return renderImage
    }
}
