//
//  HomeViewController.swift
//  SeSAC-Movie
//
//  Created by 김정호 on 12/27/24.
//

import UIKit

final class HomeViewController: UIViewController {

    // MARK: - properties
    @IBOutlet var viewArray: [UIView]!
    @IBOutlet var imageViewArray: [UIImageView]!
    @IBOutlet var top10ImageViewArray: [UIImageView]!
    
    private let imageArray: [UIImage] = [._1,
                                    ._2,
                                    ._3,
                                    ._5,
                                    .노량,
                                    .범죄도시3,
                                    .아바타,
                                    .어벤져스엔드게임]
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - methods
    private func configureUI() {
        viewArray.forEach {
            $0.layer.cornerRadius = 4
            $0.layer.borderColor = UIColor.lightGray.cgColor
            $0.layer.borderWidth = 1
        }
        
        imageViewArray.enumerated().forEach { (i, e) in
            e.layer.cornerRadius = (i == 0) ? 12 : 4
            e.layer.borderColor = UIColor.lightGray.cgColor
            e.layer.borderWidth = 1
        }
        
        top10ImageViewArray.enumerated().forEach { (i, e) in
            e.isHidden = (i == 0) ? false : true
            e.layer.cornerRadius = 4
        }
    }
    
    @IBAction func tappedPlayButton(_ sender: UIButton) {
        changeRandomImage()
        changeRandomVisibility()
    }
    
    private func changeRandomImage() {
        var images: [UIImage] = []
        
        while images.count < 4 {
            let randomImage = imageArray.randomElement()
            
            if let image = randomImage, !images.contains(image) {
                images.append(image)
            }
        }
        
        imageViewArray.enumerated().forEach { (i, e) in
            e.image = images[i]
        }
    }
    
    private func changeRandomVisibility() {
        top10ImageViewArray.forEach {
            $0.isHidden = Bool.random()
        }
    }
}
