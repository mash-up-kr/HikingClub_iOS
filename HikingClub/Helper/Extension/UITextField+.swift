//
//  UITextField+.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/15.
//

import UIKit

extension UITextField {
    func setPlaceholder(font: NDFont, color: UIColor) {
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "",
                                                   attributes: [.foregroundColor : color,
                                                                .font: UIFont.ndFont(type: font)])
    }
    
    func setFont(_ font: NDFont) {
        self.font = .ndFont(type: font)
    }
    
    func addLeftPadding(_ padding: CGFloat) {
        let paddingView = UIView(frame: .init(x: 0, y: 0, width: padding, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
    }
}
