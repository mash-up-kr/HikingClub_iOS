//
//  NDButtons.swift
//  HikingClub
//
//  Created by 남수김 on 2021/10/19.
//

import UIKit
import RxCocoa
import RxSwift

/// 버튼두개
final class NDButtons: UIView, CodeBasedProtocol {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 7
        return stackView
    }()
    
    fileprivate lazy var cancelButton: NDButton = {
        let cancel = NDButton(theme: .init(.fillGray))
        return cancel
    }()
    
    fileprivate lazy var okButton: NDButton = {
        let ok = NDButton(theme: .init(.fillGreen))
        return ok
    }()
    
    /// ok버튼이 초록색 바탕 버튼
    init(okTitle: String?, cancelTitle: String?) {
        super.init(frame: .zero)
        okButton.setTitle(okTitle, for: .normal)
        cancelButton.setTitle(cancelTitle, for: .normal)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        addSubViews(stackView)
        stackView.addArrangedSubviews(cancelButton, okButton)
        stackView.snp.makeConstraints {
            $0.leading.top.trailing.bottom.equalToSuperview()
        }
    }
}

extension Reactive where Base: NDButtons {
    var tapOk: ControlEvent<Void> {
        base.okButton.rx.tap
    }
    
    var tapCancel: ControlEvent<Void> {
        base.cancelButton.rx.tap
    }
}
