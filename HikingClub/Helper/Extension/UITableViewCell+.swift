//
//  UITableViewCell+.swift
//  HikingClub
//
//  Created by 남수김 on 2021/11/05.
//

import UIKit

extension UITableViewCell {
    func selectedColor(_ color: UIColor) {
        let selectView: UIView = {
            let view = UIView()
            view.backgroundColor = color
            return view
        }()
        selectionStyle = .default
        selectedBackgroundView = selectView
    }
}
