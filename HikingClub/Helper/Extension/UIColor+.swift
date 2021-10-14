//
//  UIColor+.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/09.
//

import UIKit

extension UIColor {
    static let green700 = UIColor(named: "green700")!
    
    static let red500 = UIColor(named: "red500")!
    
    static let gray700 = UIColor(named: "gray700")!
    static let gray100 = UIColor(named: "gray100")!
    
    var disable: UIColor {
        self.withAlphaComponent(0.3)
    }
}
