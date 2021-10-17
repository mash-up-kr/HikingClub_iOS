//
//  UIColor+.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/09.
//

import UIKit

extension UIColor {
    static let green900 = UIColor(named: "green900")!
    static let green800 = UIColor(named: "green800")!
    static let green700 = UIColor(named: "green700")!
    static let green500 = UIColor(named: "green500")!
    static let green100 = UIColor(named: "green100")!
    static let green50 = UIColor(named: "green50")!
    
    static let red500 = UIColor(named: "red500")!
    
    static let yellow500 = UIColor(named: "yellow500")!
    
    static let gray900 = UIColor(named: "gray900")!
    static let gray800 = UIColor(named: "gray800")!
    static let gray700 = UIColor(named: "gray700")!
    static let gray600 = UIColor(named: "gray600")!
    static let gray500 = UIColor(named: "gray500")!
    static let gray400 = UIColor(named: "gray400")!
    static let gray300 = UIColor(named: "gray300")!
    static let gray200 = UIColor(named: "gray200")!
    static let gray100 = UIColor(named: "gray100")!
    static let gray50 = UIColor(named: "gray50")!
    
    var disable: UIColor {
        self.withAlphaComponent(0.3)
    }
}
