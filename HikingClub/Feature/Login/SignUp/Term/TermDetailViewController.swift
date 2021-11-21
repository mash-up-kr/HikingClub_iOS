//
//  TermDetailViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/11.
//

import UIKit
import WebKit

final class TermDetailViewController: BaseViewController<TermDetailViewModel> {
    private let navigationBar: NaviBar = {
        let view = NaviBar(frame: .zero)
        view.setTitle("개인정보 처리 방침 동의")
        view.setBackItemImage()
        return view
    }()
    
    private lazy var termWebView: BaseWebView = {
        let webView = BaseWebView(self)
        let request = URLRequest(url: URL(string: "https://nadeulgil.com/terms.html")!)
        webView.load(request)
        return webView
    }()
    
    private let agreeButton: NDCTAButton = {
        let button = NDCTAButton(buttonStyle: .one)
        button.setTitle("동의하기", buttonType: .ok)
        return button
    }()
    
    var termType: SignUpTermsStackView.SignUpTermType = .personal

    // MARK: - Layout
    
    override func layout() {
        super.layout()
        view.addSubViews(navigationBar, termWebView, agreeButton)
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        termWebView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(48)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        agreeButton.snp.makeConstraints {
            $0.top.equalTo(termWebView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view)
        }
    }
    
    // MARK: - Bind
    
    override func bind() {
        super.bind()
        navigationBar.rx.tapLeftItem
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        agreeButton.rx.tapOk
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.agreementRelay.accept(Void())
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func navigateToSignUpViewController() {
        dismiss(animated: true, completion: nil)
    }
}

extension TermDetailViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) { }
}
