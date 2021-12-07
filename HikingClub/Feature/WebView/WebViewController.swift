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
        
        viewModel.shareLinkRelay
            .subscribe(onNext: { [weak self] in
                self?.showActivityControlelr($0)
            })
            .disposed(by: disposeBag)
        
        UserInformationManager.shared.isSignedOut
            .subscribe(onNext: { [weak self] in
                self?.expiredTokenProcess()
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
    
    private func showActivityControlelr(_ url: URL) {
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = view
        present(activityViewController, animated: true, completion: nil)
    }
    
    private func expiredTokenProcess() {
        guard let tabBarController = UIApplication.shared.windows.first?.rootViewController as? MainTabBarController else { return }
        tabBarController.selectTab.accept(.home)
        
        NDToastView.shared.rx.showText.onNext(.red(text: "로그인 기한이 만료되었습니다.\n다시 로그인 해 주세요."))
        
        navigationController?.popToRootViewController(animated: true)
    }
}

extension WebViewController: WKUIDelegate, WKNavigationDelegate { }
