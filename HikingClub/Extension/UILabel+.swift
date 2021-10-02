//
//  UILabel+.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/03.
//

import UIKit

extension UILabel {
    func setText(type: NDFont) {
        font = UIFont.ndFont(type: type)
    }
}
