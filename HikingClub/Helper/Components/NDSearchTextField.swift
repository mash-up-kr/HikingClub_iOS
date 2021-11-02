//
//  NDSearchTextField.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/22.
//

import UIKit
import RxSwift
import RxCocoa

final class NDSearchTextField: CodeBasedView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .fill
        return stackView
    }()
    private let containerView = UIView()
    fileprivate let textField = UITextField()
    private let iconImageView = UIImageView()
    fileprivate let cancelButton = UIButton()
    var text: String? {
        get { textField.text }
        set { textField.text = newValue }
    }
    
    override func layout() {
        super.layout()
        addSubViews(stackView)
        stackView.addArrangedSubviews(containerView, cancelButton)
        containerView.addSubViews(iconImageView, textField)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(2)
            $0.centerY.trailing.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints {
            $0.width.equalTo(35)
        }
    }
    
    override func attribute() {
        super.attribute()
        setTextField()
        setCancelButton()
        setContainerView()
        iconImageView.setImage(.icon_magnifier_left_gray900_24)
    }
    
    private func setTextField() {
        textField.setFont(.semiBold16)
        textField.textColor = .gray800
        textField.setPlaceholder(font: .semiBold16, color: .gray300)
        textField.clearButtonMode = .whileEditing
    }
    
    private func setCancelButton() {
        cancelButton.isHidden = true
        cancelButton.setFont(.medium14)
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.setTitleColor(.gray700, for: .normal)
    }
    
    private func setContainerView() {
        containerView.backgroundColor = .gray50
        containerView.layer.borderColor = UIColor.gray100.cgColor
        containerView.layer.borderWidth = 1.2
        containerView.layer.cornerRadius = 8
    }
    
    func setCancelButtonHidden(_ isHidden: Bool) {
        self.cancelButton.isHidden = isHidden
        let showAnimation = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.7) {
            self.layoutIfNeeded()
        }
        showAnimation.startAnimation()
    }
    
    func setPlaceholder(_ placeholder: String) {
        textField.placeholder = placeholder
    }
}

extension Reactive where Base: NDSearchTextField {
    var tapCancel: ControlEvent<Void> {
        base.cancelButton.rx.tap
    }
    
    var text: ControlProperty<String> {
        base.textField.rx.text.orEmpty
    }
    
    var isCancelHidden: Binder<Bool> {
        Binder(base) {
            $0.setCancelButtonHidden($1)
        }
    }
}
