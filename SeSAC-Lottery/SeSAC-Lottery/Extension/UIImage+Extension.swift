//
//  UIImage+Extension.swift
//  SeSAC-Lottery
//
//  Created by 김정호 on 1/14/25.
//

import UIKit

extension UIImage {
    func resize(width: CGFloat, height: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { _ in draw(in: CGRect(origin: .zero, size: size)) }
        
        return renderImage
    }
}
