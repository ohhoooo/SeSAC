//
//  ViewController.swift
//  SeSAC-EmotionDiary
//
//  Created by 김정호 on 12/26/24.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var happyButton: UIButton!
    @IBOutlet weak var loveButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var embarrassedButton: UIButton!
    @IBOutlet weak var upsetButton: UIButton!
    @IBOutlet weak var gloomyButton: UIButton!
    @IBOutlet weak var boredButton: UIButton!
    @IBOutlet weak var sorryButton: UIButton!
    @IBOutlet weak var sadButton: UIButton!
    @IBOutlet weak var happyLabel: UILabel!
    @IBOutlet weak var loveLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var embarrassedLabel: UILabel!
    @IBOutlet weak var upsetLabel: UILabel!
    @IBOutlet weak var gloomyLabel: UILabel!
    @IBOutlet weak var boredLabel: UILabel!
    @IBOutlet weak var sorryLabel: UILabel!
    @IBOutlet weak var sadLabel: UILabel!
    
    private lazy var buttonArray = [happyButton,
                                loveButton,
                                likeButton,
                                embarrassedButton,
                                upsetButton,
                                gloomyButton,
                                boredButton,
                                sorryButton,
                                sadButton]
    
    private lazy var labelArray = [happyLabel,
                                loveLabel,
                                likeLabel,
                                embarrassedLabel,
                                upsetLabel,
                                gloomyLabel,
                                boredLabel,
                                sorryLabel,
                                sadLabel]
    
    private let imageArray: [UIImage] = [.monoSlime1,
                                    .monoSlime2,
                                    .monoSlime3,
                                    .monoSlime4,
                                    .monoSlime5,
                                    .monoSlime6,
                                    .monoSlime7,
                                    .monoSlime8,
                                    .monoSlime9]
    
    private let stringArray = ["행복해", "사랑해", "좋아해", "당황해", "속상해", "우울해", "심심해", "미안해", "슬퍼해"]
    
    private var countArray = Array(repeating: 0, count: 9)
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - methods
    func configureUI() {
        // View
        view.backgroundColor = UIColor(red: 220/255, green: 216/255, blue: 202/255, alpha: 1)
        
        // Label
        titleLabel.text = "감정 다이어리"
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        
        labelArray.enumerated().forEach { (i, e) in
            e?.text = "\(stringArray[i]) 0"
            e?.textAlignment = .center
            e?.font = .systemFont(ofSize: 14, weight: .semibold)
        }
        
        // Button
        buttonArray.enumerated().forEach { (i, e) in
            let image = imageArray[i].resize(width: 74, height: 70)
            e?.setImage(image, for: .normal)
            e?.setTitle("", for: .normal)
        }
    }
    
    @IBAction func tappedCountButton(_ sender: UIButton) {
        // 2단계
//        let num = Int.random(in: 1...99)
//        labelArray[sender.tag]?.text = "\(stringArray[sender.tag]) \(num)"
        
        // 3단계
        countArray[sender.tag] += 1
        
        labelArray.enumerated().forEach { (i, e) in
            e?.text = "\(stringArray[i]) \(countArray[i])"
        }
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
