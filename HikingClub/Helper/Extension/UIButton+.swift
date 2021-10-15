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
    
    func setTemplateImage(named: String, tintColor color: UIColor = .gray700, for state: UIControl.State = .normal) {
        let image = UIImage(named: named)?.withRenderingMode(.alwaysTemplate)
        tintColor = color
        setImage(image, for: state)
    }
}
