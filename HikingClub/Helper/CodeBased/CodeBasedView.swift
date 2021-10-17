//
//  CodeBasedView.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/09.
//

import UIKit

class CodeBasedView: UIView, CodeBasedProtocol {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        attribute()
        layout()
    }
    
    init() {
        super.init(frame: .zero)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attribute() { }
    
    func layout() { }
}
