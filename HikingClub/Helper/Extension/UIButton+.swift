//
//  UIButton+.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/03.
//

import UIKit

extension UIButton {
    func setFont(_ type: NDFont) {
        titleLabel?.font = UIFont.ndFont(type: type)
    }
}
