//
//  RoadHashTagView.swift
//  HikingClub
//
//  Created by 이문정 on 2021/10/03.
//

import UIKit
import SnapKit

final class RoadHashTagView: UIView {
    private let hashTagLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(hashTagLabel)
        hashTagLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.bottom.equalToSuperview().inset(5)
            $0.top.equalToSuperview().offset(6)
        }
        layer.cornerRadius = 4
        backgroundColor = .gray100
    }
    
    func setText(_ text: String) -> CGFloat {
        hashTagLabel.setFont(.regular11)
        hashTagLabel.textColor = .gray700
        hashTagLabel.text = "#\(text)"
        hashTagLabel.sizeToFit()
        return hashTagLabel.frame.width + 15
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
