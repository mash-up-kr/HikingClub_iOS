//
//  MyPageListHeaderButton.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/03.
//

import UIKit

final class MyPageListHeaderButton: UIButton, CodeBasedProtocol {
    private let barIndicator = UIView()
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.setFont(.semiBold18)
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            updatedSelectStatus()
        }
    }
    
    init(_ title: String) {
        super.init(frame: .zero)
        contentLabel.text = title
        barIndicator.isHidden = true
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func layout() {
        addSubViews(contentLabel, barIndicator)
        contentLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        barIndicator.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(2)
        }
    }
    
    private func updatedSelectStatus() {
        contentLabel.textColor = isSelected ? .green500 : .gray300
        barIndicator.backgroundColor = isSelected ? .green500 : .clear
        barIndicator.isHidden = !isSelected
    }
}

