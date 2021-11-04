//
//  NDTabButton.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/26.
//

import UIKit
import RxCocoa
import RxSwift

final class NDTabButton: CodeBasedView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.distribution = .equalSpacing
        return stackView
    }()
    private let titleLabel: UILabel = UILabel()
    private let subTitleLabel: UILabel = UILabel()
    private var isSelected: Bool = false {
        didSet {
            setSelected()
            tapHandler?(isSelected)
        }
    }
    private var isEnabled: Bool = true
    /// tap할때 isSelected를 넘겨주는 클로져
    var tapHandler: ((Bool) -> Void)?
    
    override func layout() {
        super.layout()
        self.snp.makeConstraints {
            $0.height.equalTo(33)
        }
        
        addSubViews(stackView)
        stackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.top.bottom.equalToSuperview()
        }
        
        stackView.addArrangedSubviews(subTitleLabel, titleLabel)
    }
    
    override func attribute() {
        super.attribute()
        layer.cornerRadius = 8
        titleLabel.setFont(.semiBold13)
        subTitleLabel.setFont(.semiBold11)
        setSelected()
        titleLabel.isHidden = true
        subTitleLabel.isHidden = true
    }
    
    fileprivate func setSelected() {
        if isSelected {
            backgroundColor = .green500
            titleLabel.textColor = .white
            subTitleLabel.textColor = .green100
        } else {
            backgroundColor = .white
            titleLabel.textColor = .gray700
            subTitleLabel.textColor = .gray600
        }
    }
    
    func setTitle(_ title: String? = nil, subTitle: String? = nil) {
        if let title = title {
            titleLabel.text = title
            titleLabel.isHidden = false
        }
        if let subTitle = subTitle {
            subTitleLabel.text = subTitle
            subTitleLabel.isHidden = false
        }
    }
    
    func toggle() {
        isSelected = !isSelected
    }
    
    func setEnabledTouch(_ isEnabled: Bool) {
        self.isEnabled = isEnabled
    }
    
    func setSelected(_ isSelected: Bool) {
        self.isSelected = isSelected
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard isEnabled else { return }
        toggle()
    }
}
