//
//  WebViewController.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/10/02.
//

import UIKit
import WebKit

final class WebViewController: BaseViewController<WebViewModel> {
    private lazy var configuration: WKWebViewConfiguration = {
        BaseWebView.contentControllerfiguration(self.viewModel)
    }()
    private lazy var webView: BaseWebView = {
        let webView = BaseWebView(frame: .zero, configuration: configuration)
        webView.setUserTokenAtCookie()
        return webView
    }()
    
    override func attribute() {
        super.attribute()
        view.backgroundColor = .systemBackground
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        webView.load(URLRequest(url: viewModel.webURL))
    }
    
    override func layout() {
        super.layout()
        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view)
            $0.bottom.equalTo(view)
        }
    }
    
    override func bind() {
        super.bind()
        viewModel.closeAction
            .subscribe(onNext: { [weak self] _ in
                self?.closeAction()
            })
            .disposed(by: disposeBag)
    }
    
    private func closeAction() {
        if modalPresentationStyle == .fullScreen {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}

extension WebViewController: WKUIDelegate, WKNavigationDelegate { }
