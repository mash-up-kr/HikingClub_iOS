//
//  UIFont+.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/02.
//

import UIKit

enum NDFont {
    case regular11
    case regular13
    case medium12
    case medium14
    case semiBold11
    case semiBold13
    case semiBold16
    case semiBold18
    case semiBold20
    case semiBold24
    case bold16
}

extension UIFont {
    static func ndFont(type: NDFont) -> UIFont {
        switch type {
        case .regular11: return .systemFont(ofSize: 11)
        case .regular13: return .systemFont(ofSize: 13)
        case .medium12: return .systemFont(ofSize: 12, weight: .medium)
        case .medium14: return .systemFont(ofSize: 14, weight: .medium)
        case .semiBold11: return .systemFont(ofSize: 11, weight: .semibold)
        case .semiBold13: return .systemFont(ofSize: 13, weight: .semibold)
        case .semiBold16: return .systemFont(ofSize: 16, weight: .semibold)
        case .semiBold18: return .systemFont(ofSize: 18, weight: .semibold)
        case .semiBold20: return .systemFont(ofSize: 20, weight: .semibold)
        case .semiBold24: return .systemFont(ofSize: 24, weight: .semibold)
        case .bold16: return .systemFont(ofSize: 16, weight: .bold)
        }
    }
}
