//
//  SelectTownTableViewCell.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/07.
//

import UIKit

final class SelectTownTableViewCell: UITableViewCell, CodeBasedProtocol {
    private let townNameLabel: UILabel = {
        let label = UILabel()
        label.setFont(.medium14)
        label.numberOfLines = .zero
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        contentView.addSubview(townNameLabel)
        townNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    func setTownName(_ name: String) {
        townNameLabel.text = name
    }
}
