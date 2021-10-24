//
//  UIView+.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/09.
//

import UIKit

extension UIView {
    func addSubViews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    func addGradientYColor(colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = [0.0, 0.25]
        gradientLayer.startPoint = .init(x: 0, y: 0)
        gradientLayer.endPoint = .init(x: 0, y: 1)
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
}
