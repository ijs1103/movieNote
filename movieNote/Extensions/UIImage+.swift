//
//  UIImage+.swift
//  movieNote
//
//  Created by 이주상 on 2023/04/17.
//

import UIKit

extension UIImage {
    static var collectionViewImageWidth: CGFloat = 0.0
    func resize(image: UIImage, newWidth: CGFloat) -> UIImage {
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        let size = CGSize(width: newWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: size)
        let resizedImage = renderer.image { context in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
        
        return resizedImage
    }
}
