//
//  UIStoryBoard+.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/14.
//

import UIKit

extension UIStoryboard {
    func instantiate<ViewController>(_ identifier: String,
                                     _ creator: ((NSCoder) -> ViewController?)?) ->
    ViewController where ViewController: UIViewController {
        return self.instantiateViewController(identifier: identifier, creator: creator)
    }
}

