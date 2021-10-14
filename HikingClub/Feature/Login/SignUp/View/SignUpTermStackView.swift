//
//  SignUpTermStackView.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/10.
//

import UIKit
import RxSwift
import RxRelay

final class SignUpTermsStackView: UIStackView, CodeBasedProtocol {
    enum SignUpTermType {
        case personal
    }
    
    private let personalInformationTermView: SignUpTermView = SignUpTermView(.personal)
    
    let didTapDetailButton = PublishRelay<SignUpTermType>()
    
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        attribute()
        layout()
        bind()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Attribute
    
    func attribute() {
        axis = .vertical
        
        addArrangedSubviews(personalInformationTermView)
    }
    
    // MARK: - Bind
    
    func bind() {
        personalInformationTermView.detailButton.rx.tap
            .map { SignUpTermType.personal }
            .bind(to: didTapDetailButton)
            .disposed(by: disposeBag)
    }
}

private final class SignUpTermView: CodeBasedView {
    private let agreeButton: SignUpTermAgreeButton = SignUpTermAgreeButton()
    let detailButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle(">", for: .normal)
        return button
    }()
    
    private let termType: SignUpTermsStackView.SignUpTermType
    
    init(_ term:  SignUpTermsStackView.SignUpTermType) {
        termType = term
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func attribute() {
        super.attribute()
        switch termType {
        case .personal:
            agreeButton.setContent("[필수] 개인정보 처리 방침 동의")
        }
    }
    
    // MARK: - Layout
    
    override func layout() {
        super.layout()
        addSubViews(agreeButton, detailButton)
        agreeButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.bottom.equalToSuperview()
            $0.height.equalTo(56)
        }
        detailButton.snp.makeConstraints {
            $0.leading.equalTo(agreeButton.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            
            $0.width.height.equalTo(24)
        }
    }
}

private final class SignUpTermAgreeButton: UIButton, CodeBasedProtocol {
    private let checkIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.setFont(.semiBold16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    func layout() {
        addSubViews(checkIconImageView, contentLabel)
        checkIconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            
            $0.width.height.equalTo(24)
        }
        contentLabel.snp.makeConstraints {
            $0.leading.equalTo(checkIconImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview()
            
            $0.centerY.equalToSuperview()
        }
    }
    
    func setContent(_ text: String) {
        contentLabel.text = text
    }
}
