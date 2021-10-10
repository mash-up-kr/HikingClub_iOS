//
//  NDButtonTheme.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/10.
//

import UIKit

struct NDButtonTheme: NDButtonType {
    enum TextStyle {
        case large, small
    }
    var font: NDFont
    var textColor: UIColor
    var borderColor: UIColor? = nil
    var borderWidth: CGFloat? = nil
    var radius: CGFloat
    var backgroundColor: UIColor
    
    init(_ theme: NDButtonThemeColor, textStyle: TextStyle = .large, radius: CGFloat = 8) {
        font = textStyle == .large ? .semiBold16 : .semiBold13
        textColor = theme.textColor
        borderColor = theme.borderColor
        borderWidth = theme.borderColor == nil ? nil : 1.5
        self.radius = radius
        backgroundColor = theme.backgroundColor
    }
}

enum NDButtonThemeColor {
    case fillGreen
    case fillGray
    case strokeGreen
    
    var textColor: UIColor {
        switch self {
        case .fillGreen:
            return .white
        case .fillGray:
            return .gray700
        case .strokeGreen:
            return .green700
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .fillGreen:
            return .green700
        case .fillGray:
            return .gray100
        case .strokeGreen:
            return .white
        }
    }
    
    var borderColor: UIColor? {
        switch self {
        case .fillGreen, .fillGray:
            return nil
        case .strokeGreen:
            return .green700
        }
    }
}

protocol NDButtonType {
    // Text
    var font: NDFont { get }
    var textColor: UIColor { get }
    
    // Border
    var borderColor: UIColor? { get }
    var borderWidth: CGFloat? { get }
    var radius: CGFloat { get }
    
    // View
    var backgroundColor: UIColor { get }
}
