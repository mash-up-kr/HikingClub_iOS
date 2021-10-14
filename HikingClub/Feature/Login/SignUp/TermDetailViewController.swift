//
//  TermDetailViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/11.
//

import UIKit

final class TermDetailViewController: BaseViewController<BaseViewModel> {
    private let navigationArea: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private let termTextView: UITextView = {
        let textView = UITextView()
        textView.font = .ndFont(type: .medium12)
        return textView
    }()
    
    // TODO: CAT Button Component로 교쳬 예정
    private let agreeButton: UIButton = {
        let button = UIButton()
        button.setTitle("동의하기", for: .normal)
        button.backgroundColor = .gray
        return button
    }()
    
    var termType: SignUpTermsStackView.SignUpTermType = .personal

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        bind()
    }
    
    // MARK: - Attribute
    
    private func attribute() {
        setTermText()
    }
    
    // TODO: Config등 텍스트를 모아두는 파일에 해당 텍스트를 모아두어야 할 듯
    private func setTermText() {
        switch termType {
        case .personal:
            termTextView.text =
            """
            앱 ‘나들길’ 개발팀 ‘매시업 산악회 11기’는 회원의 개인정보를 소중히 보호하고 있습니다. 아래의 개인정보 수집 및 이용, 제공에 대한 내용을 주의 깊게 읽어 보신 후 동의해주시면 다음 단계를 진행할 수 있습니다.

            ** 개인정보 수집 및 이용에 대한 동의(필수)**
            [개인정보 처리 목적]
            A. 서비스 제공
            콘텐츠 제공, 구매 및 요금 결제, 물품배송 또는 청구서 등 발송, 요금추심 등 서비스 제공에 관한 계약의 이행 및 요금정산과 관련한 목적으로 개인정보를 처리합니다.

            B. 서비스 개선
            콘텐츠 등 기존 서비스 제공에 더하여, 인구통계학적 분석, 서비스 방문 및 이용기록의 분석, 개인정보 및 관심에 기반한 맞춤형 서비스 제공 등 신규 서비스 요소의 발굴 및 기존 서비스 개선 등을 위하여 개인정보를 이용하며, 서비스 이용기록과 접속 빈도 분석, 서비스 이용에 대한 통계, 서비스 분석 및 통계에 따른 맞춤 서비스 제공 및 광고 게재 등에 개인정보를 이용합니다.

            1.  수집 항목 및 수집 목적
                1. 수집 항목 : 아이디, 비밀번호, 닉네임
                2. 수집 목적 : 개인 회원 식별 및 게시물 내용과 사진, 길 데이터 데이터 관리를 위함.

            2. 보유 및 이용기간
                1. 가입 이후, 탈퇴시까지
                    1. 개인정보 페이지 - 설정 페이지에서 탈퇴가 가능합니다.
                    2. 탈퇴 시 즉시 데이터 삭제
                    3. 정보주체의 별도 요청이 있는 경우에는 지체 없이 탈퇴 및 삭제
                    4. 본인확인이 불가한경우 탈퇴에 제한이 있을 수 있습니다.
                        1. 아이디로 사용한 이메일 탈퇴로 이메일 인증이 불가한 경우
                        2. 비밀번호 재설정이 불가한 경우
                        3. 이메일로 본인확인이 불가한 경우

            3.  회원 가입자는 개인정보 수집 및 이용에 동의하지 않을 권리가 있습니다. 다만, 상기 개인정보를 제공하지 않으실 경우 회원가입에 제한이 있을 수 있습니다.
            """
        }
    }
    
    // MARK: - Layout
    
    private func layout() {
        view.addSubViews(navigationArea, termTextView, agreeButton)
        navigationArea.snp.makeConstraints {
            $0.top.equalTo(view)
            $0.leading.trailing.equalToSuperview()
            
            $0.height.equalTo(98)
        }
        termTextView.snp.makeConstraints {
            $0.top.equalTo(navigationArea.snp.bottom).offset(48)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        agreeButton.snp.makeConstraints {
            $0.top.equalTo(termTextView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view)
            
            $0.height.equalTo(122)
        }
    }
    
    // MARK: - Bind
    
    private func bind() {
        agreeButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.navigateToSignUpViewController()
            })
            .disposed(by: disposeBag)
    }
    
    private func navigateToSignUpViewController() {
        dismiss(animated: true, completion: nil)
    }
}
