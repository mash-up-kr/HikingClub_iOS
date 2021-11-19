//
//  NDCTAButton.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/19.
//

import UIKit
import RxSwift
import RxCocoa

/// 그라데이션 투명처리되어있는 버튼
/// - NOTE: setGradientColor 호출해줘야 뒷배경 효과적용됨
final class NDCTAButton: UIView, CodeBasedProtocol {
    enum ButtonStyle {
        case one
        case two
    }
    
    enum ButtonType {
        case ok
        case cancel
    }
    
    private let containerView: UIView = UIView()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 7
        return stackView
    }()
    fileprivate let okButton: NDButton = NDButton(theme: .init(.fillGreen))
    fileprivate let cancelButton: NDButton = NDButton(theme: .init(.fillGray))
    private let buttonStyle: ButtonStyle
    
    init(buttonStyle: ButtonStyle) {
        self.buttonStyle = buttonStyle
        super.init(frame: .zero)
        layout()
        attribute()
    }
    
    func layout() {
        addSubViews(containerView, stackView)
        if buttonStyle == .one {
            stackView.addArrangedSubviews(okButton)
        } else {
            stackView.addArrangedSubviews(cancelButton, okButton)
        }
        
        containerView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(116)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(28)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(54)
        }
    }
    
    func attribute() {
        backgroundColor = .systemBackground
        containerView.backgroundColor = .systemBackground
    }
    
    /// - NOTE: viewDidLoad이후 호출해야함
    func setGradientColor() {
        let topColor = UIColor.white.withAlphaComponent(0).cgColor
        let bottomColor = UIColor.white.cgColor
        containerView.addGradientYColor(colors: [topColor, bottomColor])
    }
    
    func setTitle(_ title: String, buttonType: ButtonType) {
        if buttonType == .ok {
            okButton.setTitle(title, for: .normal)
        } else {
            cancelButton.setTitle(title, for: .normal)
        }
    }
    
    func setEnabled(_ isEnabled: Bool, type: ButtonType) {
        if type == .ok {
            okButton.rx.isEnabled.onNext(isEnabled)
        } else {
            cancelButton.rx.isEnabled.onNext(isEnabled)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Reactive where Base: NDCTAButton {
    var tapOk: ControlEvent<Void> {
        base.okButton.rx.tap
    }
    
    var tapCancel: ControlEvent<Void> {
        base.cancelButton.rx.tap
    }
    
    // ok버튼만 활성/비활성 됩니다.
    var isEnabled: Binder<Bool> {
        Binder(base) { $0.setEnabled($1, type: .ok) }
    }
}
