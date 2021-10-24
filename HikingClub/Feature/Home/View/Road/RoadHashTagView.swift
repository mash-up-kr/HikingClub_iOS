//
//  RoadHashTagView.swift
//  HikingClub
//
//  Created by 이문정 on 2021/10/03.
//

import UIKit
import SnapKit

class RoadHashTagView: UIView {
    private let hashTagLable = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(hashTagLable)
        hashTagLable.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.bottom.equalToSuperview().inset(5)
            $0.top.equalToSuperview().offset(6)
        }
        
        backgroundColor = .gray
    }
    
    func setText(_ text: String) -> CGFloat {
        hashTagLable.setFont(.regular11)
        hashTagLable.text = text
        hashTagLable.sizeToFit()
        return hashTagLable.frame.width + 10
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
