//
//  InquiryListCell.swift
//  HikingClub
//
//  Created by 이문정 on 2021/11/14.
//

import UIKit

final class InquiryListCell: UIButton, CodeBasedProtocol {
    
    private let iconImageView = UIImageView()
    
    private let contentStackView: UIStackView = {
       let view = UIStackView()
        view.axis = .vertical
        view.spacing = 13
        return view
    }()
    
    private let inquiryLabel: UILabel = {
        let label = UILabel()
        label.setFont(.medium14)
        label.textColor = .green700
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.setFont(.medium12)
        label.textColor = .green500
        return label
    }()
    
    func attribute() {
        inquiryLabel
    }
    
}
