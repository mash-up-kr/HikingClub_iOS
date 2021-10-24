//
//  UITabBarItem+.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/20.
//

import UIKit

extension UITabBarItem {
    convenience init(normalAsset: AssetImage, selectedAsset: AssetImage) {
        let normalImage = normalAsset.image?.withRenderingMode(.alwaysOriginal)
        let selectedImage = selectedAsset.image?.withRenderingMode(.alwaysOriginal)
        self.init(title: nil, image: normalImage, selectedImage: selectedImage)
    }
}
